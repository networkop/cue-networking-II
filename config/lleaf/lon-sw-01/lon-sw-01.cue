package main

hostvars: "lon-sw-01": {
	name: "lon-sw-01"
	device_role: name: "lleaf"
	id: "5e226d38-9d22-4da6-b3b3-9379e24613e6"
	local_context_data: bgp_asn: 65000
	device_type: manufacturer: name: "NVIDIA1"
	interfaces: [{
		name: "loopback0"
		ip_addresses: [{
			address: "198.51.100.1/32"
		}]
	}]
}
