package main

hostvars: "lon-sw-02": {
	name: "lon-sw-02"
	device_role: name: "sspine"
	id: "a92a9c1e-53c6-4df6-a046-96afc6764eb6"
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
