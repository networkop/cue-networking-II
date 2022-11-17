package main

hostvars: "lon-sw-02": {
	name: "lon-sw-02"
	device_role: name: "sspine"
	id: "60063cb1-79e9-4884-96f7-1a8b7885c6a5"
	device_type: manufacturer: name: "Arista1"
	interfaces: [{
		name: "loopback0"
		ip_addresses: [{
			address: "198.51.100.2/32"
		}]
	}]
}
