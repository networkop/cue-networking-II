package main

import (
	"tool/cli"
	"tool/http"
	"encoding/json"
	"github.com/networkop/cue-networking-II/inventory"
	"list"
)

command: {
	apply: {
		for _, dev in inventory.#devices {
			(dev.name): {
				start: cli.Print & {
					text: "Processing device \(dev.name)"
				}

				myVendor: applyResource & {
					apiURL:       "\(inventory.ipam.url)/dcim/manufacturers/"
					queryName:    "name"
					queryValue:   dev.vendor
					resourceName: "manufacturer"
					resource: {
						name: dev.vendor
					}
				}

				mySite: applyResource & {
					apiURL:       "\(inventory.ipam.url)/dcim/sites/"
					queryName:    "name"
					queryValue:   dev.site
					resourceName: "site"
					resource: {
						name:   dev.site
						status: dev.status
					}
				}

				myRole: applyResource & {
					apiURL:       "\(inventory.ipam.url)/dcim/device-roles/"
					queryName:    "name"
					queryValue:   dev.role
					resourceName: "role"
					resource: {
						name: dev.role
					}
				}

				myModel: applyResource & {
					apiURL:       "\(inventory.ipam.url)/dcim/device-types/"
					queryName:    "model"
					queryValue:   dev.type
					resourceName: "model"
					resource: {
						model:        dev.type
						manufacturer: myVendor.guard.resourceID
					}
				}

				myDevice: applyResource & {
					apiURL:       "\(inventory.ipam.url)/dcim/devices/"
					queryName:    "name"
					queryValue:   dev.name
					resourceName: "device"
					resource: {
						name:        dev.name
						device_type: myModel.guard.resourceID
						site:        mySite.guard.resourceID
						device_role: myRole.guard.resourceID
						status:      dev.status
						local_context_data: {
							bgp_asn:   dev.asn
							bgp_intfs: dev.uplinks
						}
					}
				}

				myLoopback: applyResource & {
					apiURL:       "\(inventory.ipam.url)/dcim/interfaces/"
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
					apiURL:       "\(inventory.ipam.url)/ipam/ip-addresses/"
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
		for _, dev in inventory.#devices {
			(dev.name): {
				start: cli.Print & {
					text: "Deleting resources for \(dev.name)"
				}

				deleteDevice: deleteResource & {
					apiURL:       "\(inventory.ipam.url)/dcim/devices/"
					queryName:    "name"
					queryValue:   dev.name
					resourceName: "device"
				}

				deleteModel: deleteResource & {
					apiURL:       "\(inventory.ipam.url)/dcim/device-types/"
					queryName:    "model"
					queryValue:   dev.type
					resourceName: "model"
					getResource: $after: deleteDevice.guard.deleteResource
				}

				deleteVendor: deleteResource & {
					apiURL:       "\(inventory.ipam.url)/dcim/manufacturers/"
					queryName:    "name"
					queryValue:   dev.vendor
					resourceName: "manufacturer"
					getResource: $after: deleteModel.guard.deleteResource
				}

				deleteIP: deleteResource & {
					apiURL:       "\(inventory.ipam.url)/ipam/ip-addresses/"
					queryName:    "address"
					queryValue:   dev.loopback
					resourceName: "ipaddress"
				}
			}
		}
	}
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
		request: inventory.ipam.headers
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
					request: inventory.ipam.headers & {
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

deleteResource: {
	// input args
	apiURL:       string
	queryName:    string
	queryValue:   string
	resourceName: string
	dep: {}

	let query = "\(queryName)=\(queryValue)"

	getResource: http.Get & {
		url:     apiURL + "?\(query)"
		request: inventory.ipam.headers
		$after:  dep
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

			deleteResource: http.Delete & {
				url:     apiURL
				request: inventory.ipam.headers & {
					body: json.Marshal([{
						id: resourceID
					}])
				}
			}
			deleteResourceCheck: cli.Print & {
				text: "Delete \(resourceName)[\(query)] response is '\(deleteResource.response.status)'"
			}
		}
	}
}
