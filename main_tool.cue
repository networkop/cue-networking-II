package main

import (

	"tool/cli"
	"encoding/yaml"
	"github.com/networkop/cue-networking-II/inventory"
)

command: try: {
	for _, dev in inventory.#devices {
		(dev.name): {
			let conf = hostvars[(dev.name)]
			cli.Print & {
				text: "-== hostvars[\(dev.name)] ==-\n" + yaml.Marshal(conf)
			}
		}
	}
}
