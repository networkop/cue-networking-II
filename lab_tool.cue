package main

import (
	"tool/exec"
)

command: "lab-up": {
	commands: exec.Run & {
		cmd: ["sudo", "containerlab", "deploy", "--reconfigure", "-t", "two-node.yml"]
		dir: "./lab"
	}
}

command: "lab-down": {
	commands: exec.Run & {
		cmd: ["sudo", "containerlab", "destroy", "-t", "two-node.yml"]
		dir: "./lab"
	}
}
