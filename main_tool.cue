package main

import (

	"tool/cli"
	"tool/exec"
	"tool/http"
	"strings"
	"encoding/json"
	"encoding/yaml"
	"encoding/base64"
	"github.com/networkop/cue-networking-II/inventory"
)

command: try: {
	for _, dev in inventory.#devices {
		(dev.name): {
			let vars = hostvars[(dev.name)]
			hvars: cli.Print & {
				text: "-== hostvars[\(dev.name)] ==-\n" + yaml.Marshal(vars)
			}
		}
	}
}

command: show: {
	for _, dev in inventory.#devices {
		(dev.name): {
			let conf = config[(dev.name)]
			if dev.vendor == "Arista1" {
				commands: exec.Run & {
					cmd: ["j2", "--tests", "jinja/tests/defined.py", "--filters", "jinja/filters/combined.py", "-f", "json", "schemas/arista/eos.conf_original.j2", "-"]
					stdin:  json.Marshal(conf)
					stdout: string
				}
				split: strings.Split(commands.stdout, "\n")
				split_commands: [ for x in split if x != "" {x}]
				print: cli.Print & {
					text: "-== configs[\(dev.name)] ==-\n" + strings.Join(split_commands, "\n")
				}
			}
			if dev.vendor == "NVIDIA1" {
				cfgs: cli.Print & {
					text: "-== configs[\(dev.name)] ==-\n" + yaml.Marshal(conf)
				}
			}
		}
	}
}

jsonrpc_body: {
	jsonrpc: "2.0"
	method:  "runCmds"
	params: {
		version: 1
		cmds: [...string]
	}
}

eapi_wrapper: {
	input: [...string]
	output: ["enable", "configure"] + input + ["write"]
}

saveNVUE: {
	state: "apply"
	"auto-prompt": {
		ays:           "ays_yes"
		"ignore_fail": "ignore_fail_yes"
	}
}

command: push: {
	for _, dev in inventory.#devices {
		let auth = base64.Encode(null, "\(dev.user):\(dev.password)")
		let conf = config[(dev.name)]

		(dev.name): {
			if dev.vendor == "Arista1" {
				commands: exec.Run & {
					cmd: ["j2", "--tests", "jinja/tests/defined.py", "--filters", "jinja/filters/combined.py", "-f", "json", "schemas/arista/eos.conf_original.j2", "-"]
					stdin:  json.Marshal(conf)
					stdout: string
				}

				split: strings.Split(commands.stdout, "\n")

				split_commands: [ for x in split if x != "" {x}]

				wrapped_commands: eapi_wrapper & {input: split_commands}

				create: http.Post & {
					url: "https://\(dev.name):443/command-api"
					tls: verify: false
					request: {
						header: "Authorization": "Basic \(auth)"
						body: json.Marshal(jsonrpc_body & {
							params: cmds: wrapped_commands.output
							id: dev.name
						})
					}
				}

				response: cli.Print & {
					text: "CREATE RESPONSE \(create.response.body)"
				}
			}
			if dev.vendor == "NVIDIA1" {

				createRevision: http.Post & {
					url: "https://\(dev.name):8765/nvue_v1/revision"
					tls: verify: false
					request: header: "Authorization": "Basic \(auth)"
				}

				revisionID: [ for k, v in json.Unmarshal(createRevision.response.body) {k}]
				escapedID: strings.Replace(revisionID[0], "/", "%2F", -1)

				patchRevision: http.Do & {
					method: "PATCH"
					url:    "https://\(dev.name):8765/nvue_v1/?rev=\(escapedID)"
					tls: verify: false
					request: header: "Authorization": "Basic \(auth)"
					request: header: "Content-Type":  "application/json"
					request: body: json.Marshal(conf)
				}

				checkPatch: cli.Print & {
					text: "PATCH RESPONSE: \(patchRevision.response.body)"
				}

				applyRevision: http.Do & {
					$after: patchRevision
					method: "PATCH"
					url:    "https://\(dev.name):8765/nvue_v1/revision/\(escapedID)"
					tls: verify: false
					request: header: "Authorization": "Basic \(auth)"
					request: header: "Content-Type":  "application/json"
					request: body: json.Marshal(saveNVUE)
				}

				checkApply: cli.Print & {
					text: "APPLY RESPONSE \(applyRevision.response.body)"
				}
			}
		}
	}
}
