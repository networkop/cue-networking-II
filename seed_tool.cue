package seed

import (
	"tool/cli"
	"tool/http"
	"encoding/json"
	"list"
)

#inventory: [{
	name:     "lon-sw-01"
	vendor:   "NVIDIA1"
	type:     "SN4700"
	role:     "switch"
	site:     "LON1"
	status:   "Active"
	loopback: "198.51.100.1/32"
}, {
	name:     "lon-sw-02"
	vendor:   "Arista1"
	type:     "7050X3"
	role:     "switch"
	site:     "LON2"
	status:   "Active"
	loopback: "198.51.100.2/32"
}]

ipam:  *"demo.nautobot.com/api" | string                    @tag(ipam)
token: *"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" | string @tag(token)
ipamHeaders: header: {
	"Authorization": "Token \(token)"
	"Accept":        "application/json"
	"Content-Type":  "application/json"
}

applyResource: {
	// input args
	apiURL:     string
	queryName:  string
	queryValue: string
	resource: {}
	resourceName: string

	let query = "\(queryName)=\(queryValue)"

	getResource: http.Get & {
		url:     apiURL + "?\(query)"
		request: ipamHeaders
	}
	getResponse: json.Unmarshal(getResource.response.body)

	//getLog: cli.Print & {
	// text: "getResource: \(resourceName)[\(query)]: \(getResource.response.status)"
	//}

	// guarding conditionals due to https://github.com/cue-lang/cue/issues/1593
	guard: {
		if getResource.response.statusCode == 200 {

			if list.MinItems(getResponse.results, 1) {
				check: cli.Print & {
					text: "Found \(resourceName)[\(query)] with ID \(getResponse.results[0].id)"
				}
				resourceID: getResponse.results[0].id
			}
			if list.MaxItems(getResponse.results, 0) {

				createResource: http.Post & {
					url:     apiURL
					request: ipamHeaders & {
						body: json.Marshal(resource)
					}
				}
				//createLog: cli.Print & {
				// text: "createResource:  \(createResource.response.body)"
				//}

				createResponse: json.Unmarshal(createResource.response.body)
				check:          cli.Print & {
					text: "Created \(resourceName)[\(query)] with ID \(createResponse.id)"
				}
				resourceID: createResponse.id
			}
		}
	}

}

command: {
	apply: {
		for _, dev in #inventory {
			(dev.name): {
				start: cli.Print & {
					text: "Processing device \(dev.name)"
				}

				myVendor: applyResource & {
					apiURL:       "https://\(ipam)/dcim/manufacturers/"
					queryName:    "name"
					queryValue:   dev.vendor
					resourceName: "manufacturer"
					resource: {
						name: dev.vendor
					}
				}

				mySite: applyResource & {
					apiURL:       "https://\(ipam)/dcim/sites/"
					queryName:    "name"
					queryValue:   dev.site
					resourceName: "site"
					resource: {
						name:   dev.site
						status: dev.status
					}
				}

				myRole: applyResource & {
					apiURL:       "https://\(ipam)/dcim/device-roles/"
					queryName:    "name"
					queryValue:   dev.role
					resourceName: "role"
					resource: {
						name: dev.role
					}
				}

				myModel: applyResource & {
					apiURL:       "https://\(ipam)/dcim/device-types/"
					queryName:    "model"
					queryValue:   dev.type
					resourceName: "model"
					resource: {
						model:        dev.type
						manufacturer: myVendor.guard.resourceID
					}
				}

				myDevice: applyResource & {
					apiURL:       "https://\(ipam)/dcim/devices/"
					queryName:    "name"
					queryValue:   dev.name
					resourceName: "device"
					resource: {
						name:        dev.name
						device_type: myModel.guard.resourceID
						site:        mySite.guard.resourceID
						device_role: myRole.guard.resourceID
						status:      dev.status
					}
				}

				myLoopback: applyResource & {
					apiURL:       "https://\(ipam)/dcim/interfaces/"
					queryName:    "device_id"
					queryValue:   myDevice.guard.resourceID
					resourceName: "interface"
					resource: {
						name:   "loopback0"
						device: myDevice.guard.resourceID
						status: dev.status
						role:   "loopback"
						type:   "virtual"
					}
				}

				myIP: applyResource & {
					apiURL:       "https://\(ipam)/ipam/ip-addresses/"
					queryName:    "address"
					queryValue:   dev.loopback
					resourceName: "ipaddress"
					resource: {
						address:              dev.loopback
						assigned_object_type: "dcim.interface"
						assigned_object_id:   myLoopback.guard.resourceID
						status:               dev.status
						type:                 "virtual"
						role:                 "loopback"
					}
				}
			}
		}
	}
}

command: {
	cleanup: {
		for _, dev in #inventory {
			(dev.name): {
				start: cli.Print & {
					text: "Deleting resources for \(dev.name)"
				}

				deleteDevice: deleteResource & {
					apiURL:       "https://\(ipam)/dcim/devices/"
					queryName:    "name"
					queryValue:   dev.name
					resourceName: "device"
				}

				deleteModel: deleteResource & {
					apiURL:       "https://\(ipam)/dcim/device-types/"
					queryName:    "model"
					queryValue:   dev.type
					resourceName: "model"
					dep:          deleteDevice.guard.resourceID
				}

				deleteVendor: deleteResource & {
					apiURL:       "https://\(ipam)/dcim/manufacturers/"
					queryName:    "name"
					queryValue:   dev.vendor
					resourceName: "manufacturer"
					dep:          deleteModel.guard.resourceID
				}

				deleteIP: deleteResource & {
					apiURL:       "https://\(ipam)/ipam/ip-addresses/"
					queryName:    "address"
					queryValue:   dev.loopback
					resourceName: "ipaddress"
				}
			}
		}
	}
}

deleteResource: {
	// input args
	apiURL:       string
	queryName:    string
	queryValue:   string
	resourceName: string

	let query = "\(queryName)=\(queryValue)"

	getResource: http.Get & {
		url:     apiURL + "?\(query)"
		request: ipamHeaders
	}

	//logResource: cli.Print & {
	// text: "getResource: \(getResource.response.body)"
	//}
	getResponse: json.Unmarshal(getResource.response.body)

	guard: {
		if getResource.response.statusCode == 200 && list.MinItems(getResponse.results, 1) {
			check: cli.Print & {
				text: "Found \(resourceName)[\(query)] with ID \(getResponse.results[0].id)"
			}
			resourceID: getResponse.results[0].id 

			deleteDevice: http.Delete & {
				url:     apiURL
				request: ipamHeaders & {
					body: json.Marshal([{
						id: resourceID
					}])
				}
			}
			deleteDeviceCheck: cli.Print & {
				text: "Delete \(resourceName)[\(query)] response is '\(deleteDevice.response.status)'"
			}
		}
	}
}
