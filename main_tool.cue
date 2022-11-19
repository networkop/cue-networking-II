package main

import (

	"tool/cli"
	"tool/exec"
	"strings"
	"encoding/json"
	"encoding/yaml"
	"github.com/networkop/cue-networking-II/inventory"
)

command: try: {
	for _, dev in inventory.#devices {
		(dev.name): {
			let vars = hostvars[(dev.name)]
			hvars: cli.Print & {
				text: "-== hostvars[\(dev.name)] ==-\n" + yaml.Marshal(vars)
			}
			let conf = config[(dev.name)]
			cfgs: cli.Print & {
				text: "-== configs[\(dev.name)] ==-\n" + yaml.Marshal(conf)
			}

			if dev.vendor == "Arista1" {
				commands: exec.Run & {
					cmd: ["j2", "-f", "json", "schemas/arista/eos.conf.j2", "-"]
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
