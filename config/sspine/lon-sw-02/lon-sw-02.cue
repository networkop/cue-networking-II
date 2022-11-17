package main

hostvars: "lon-sw-02": {
	name: "lon-sw-02"
	device_role: name: "sspine"
	id: "40fc96fa-226c-4264-b859-5dca599e81d7"
	local_context_data: bgp_asn: 65001
	device_type: manufacturer: name: "Arista1"
	interfaces: [{
		name: "loopback0"
		ip_addresses: [{
			address: "198.51.100.2/32"
		}]
	}]
}
