package main

import (
	"list"
	"tool/cli"
	"tool/exec"
	"text/template"
	"tool/file"
	"tool/http"
	"encoding/json"
	"encoding/yaml"
	"github.com/networkop/cue-networking-II/inventory"
)

gqlQuery: file.Read & {
	filename: "query.gql"
	contents: string
}

command: fetch: {

	for _, dev in inventory.#devices {
		(dev.name): {

			gqlRequest: http.Post & {
				url:     inventory.ipam.url + "/graphql/"
				request: inventory.ipam.headers & {
					body: json.Marshal({
						query: template.Execute(gqlQuery.contents, {name: dev.name})
					})
				}
			}

			log: cli.Print & {
				text: "gql response: \(gqlRequest.response.body)"
			}

			response: json.Unmarshal(gqlRequest.response.body)

			if list.MinItems(response.data.devices, 1) {
				let device = response.data.devices[0]
				let dirName = "config/\(device.device_role.name)/\(device.name)"

				dirs: file.MkdirAll & {
					path: "\(dirName)"
				}

				input: file.Create & {
					filename: "\(dirName)/\(device.name).yml"
					contents: yaml.Marshal(device)
				}

				gen: exec.Run & {
					cmd:    "cue import -p main -f -l \"hostvars\" -l name \(device.name).yml"
					dir:    "\(dirName)"
					$after: input
				}
			}
		}
	}
}
