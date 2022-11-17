package main

import (
  "list"
	"tool/cli"
	"text/template"
	"tool/file"
	"tool/http"
	"encoding/json"
  "encoding/yaml"
	"github.com/networkop/cue-networking-II/inventory"
)

gqlQuery: """
	query {
	  devices(name: "{{.name}}") {
	    name
	    device_role {
	      name
	    }
	    id
	    device_type {
	      manufacturer {
	        name
	      }
	    }
	    interfaces {
	      name
	      ip_addresses {
	        address
	      }
	    }
	  }
	}
	"""

command: fetch: {
	for _, dev in inventory.#devices {
		(dev.name): {

			gqlRequest: http.Post & {
				url:     inventory._ipam.url + "/graphql/"
				request: inventory._ipam.headers & {
					body: json.Marshal({
						query: template.Execute(gqlQuery, {name: dev.name})
					})
				}
			}

			log: cli.Print & {
			 text: "gql response: \(gqlRequest.response.body)"
			}

			response: json.Unmarshal(gqlRequest.response.body)

			if list.MinItems(response.data.devices, 1) {
				let device = response.data.devices[0]
        let dir = "\(device.device_role.name)/\(device.name)"

				dirs: file.MkdirAll & {
					path: "\(dir)"
				}

        input: file.Create & {
          filename: "\(dir)/\(device.name).yml"
          contents: yaml.Marshal(device)
        }

			}

		}
	}
}
