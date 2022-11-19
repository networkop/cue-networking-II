package main

hostvars: "lon-sw-02": {
	name: "lon-sw-02"
	device_role: name: "sspine"
	id: "26a022b4-3eeb-40bc-b434-cc9f67a655c4"
	local_context_data: {
		bgp_asn: 65001
		bgp_intfs: [
			"Ethernet1",
		]
	}
	device_type: manufacturer: name: "Arista1"
	interfaces: [{
		name: "loopback0"
		ip_addresses: [{
			address: "198.51.100.2/32"
		}]
	}]
}
