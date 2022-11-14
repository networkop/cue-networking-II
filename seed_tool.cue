package seed

import (
	"tool/cli"
	"tool/http"
	"encoding/json"
	"list"
)

#inventory: [{
	name:   "sw01"
	vendor: "NVIDIA1"
	type:   "SN4700"
}, {
	name:   "sw02"
	vendor: "Arista1"
	type:   "7050X3"
}]

ipam:  *"demo.nautobot.com/api" | string                    @tag(ipam)
token: *"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" | string @tag(token)
ipamHeaders: header: {
	"Authorization": "Token \(token)"
	"Accept":        "application/json"
	"Content-Type":  "application/json"
}

command: test: {
	for _, device in #inventory {
		(device.name): {
			start: cli.Print & {
				text: "Processing device \(device.name)"
			}

			let manufacturerAPI = "https://\(ipam)/dcim/manufacturers/"
			manufacturerID: string

			getManufacturer: http.Get & {
				url:     manufacturerAPI + "?name=\(device.vendor)"
				request: ipamHeaders
			}
			getResponse: json.Unmarshal(getManufacturer.response.body)

			if getManufacturer.response.statusCode == 200 && list.MinItems(getResponse.results, 1) {
				getCheck: cli.Print & {
					text: "ManufacturerID for \(device.vendor) is \(getResponse.results[0].id)"
				}
				manufacturerID: getResponse.results[0].id
			}

			if getManufacturer.response.statusCode == 200 && list.MaxItems(getResponse.results, 0) {

				createManufacturer: http.Post & {
					url:     manufacturerAPI
					request: ipamHeaders & {
						body: json.Marshal({
							name:    device.vendor
							display: device.vendor
						})
					}
				}

				createResponse: json.Unmarshal(createManufacturer.response.body)
				createCheck:    cli.Print & {
					text: "ManufacturerID for \(device.vendor) is \(createResponse.id)"
				}
				manufacturerID: createResponse.id
			}
		}

	}
}
