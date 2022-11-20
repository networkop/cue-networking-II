package main

import (
	"net"
	"strings"
)

hostvars: [Name=_]: {
	name: Name
	device_role: name: string
	id: string
	device_type: manufacturer: name: string
	interfaces: [...{
		name: string
		ip_addresses: [...{
			address: string & net.IPCIDR
		}]
	}]
	local_context_data: bgp_asn: <=65535 & >=64512

	// computed values
	loopbackIP: string & net.IPCIDR
	for _, intf in interfaces {
		if intf.name == "loopback0" {
			if len(intf.ip_addresses) > 0 {
				loopbackIP: intf.ip_addresses[0].address
			}
		}
	}
	routerID: string & net.IP
	routerID: strings.Split(loopbackIP, "/")[0]
}
