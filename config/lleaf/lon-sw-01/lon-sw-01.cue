package main

hostvars: "lon-sw-01": {
	name: "lon-sw-01"
	device_role: name: "lleaf"
	id: "67d378c9-7a66-4e9f-b4d1-58188ecc6254"
	local_context_data: {
		bgp_asn: 65000
		bgp_intfs: [
			"swp1",
		]
	}
	device_type: manufacturer: name: "NVIDIA1"
	interfaces: [{
		name: "loopback0"
		ip_addresses: [{
			address: "198.51.100.1/32"
		}]
	}]
}
