package main

import (
	nvidia "github.com/networkop/cue-networking-II/schemas/nvidia:schema"
	arista "github.com/networkop/cue-networking-II/schemas/arista:schema"
	"strings"
)

// Transforming hostvars into structred device configs

config: {
	for host, vars in hostvars {
		(host): {
			if vars.device_type.manufacturer.name == "NVIDIA1" {
				nvidiaX & {_input: vars}
			}
			if vars.device_type.manufacturer.name == "Arista1" {
				aristaX & {_input: vars}
			}
		}
	}
}

// nvidia-specific transformations
nvidiaX: {
	_input: {}
	nvidia.#set & {
		interface: {
			for _, intf in _input.interfaces {
				if strings.HasPrefix(intf.name, "loopback") {
					lo: {
						ip: address: (intf.ip_addresses[0].address): {}
						type: "loopback"
					}
				}
			}
			for _, intf in _input.local_context_data.bgp_intfs {
				(intf): type: "swp"
			}
		}
		router: bgp: enable: "on"
		vrf: default: router: bgp: {
			"address-family": "ipv4-unicast": {
				enable: "on"
				redistribute: connected: enable: "on"
			}
			"autonomous-system": _input.local_context_data.bgp_asn
			"router-id":         _input.routerID
			enable:              "on"
			for _, intf in _input.local_context_data.bgp_intfs {
				neighbor: (intf): {
					"remote-as": "external"
					type:        "unnumbered"
				}
			}
		}
	}
}

aristaX: {
	_input: {}
	arista.#config & {
		ipv6_unicast_routing:       true
		ip_routing_ipv6_interfaces: true
		for _, intf in _input.interfaces {
			if strings.HasPrefix(intf.name, "loopback") {
				loopback_interfaces: [{
					name:       intf.name
					ip_address: intf.ip_addresses[0].address
					// workarounds for jinja2.exceptions.UndefinedError: 'dict object' has no attribute 'mpls'
					mpls: ldp: {}
					node_segment: {}
				}]
			}
		}
		for _, intf in _input.local_context_data.bgp_intfs {
			ethernet_interfaces: [{
				name:        intf
				type:        "routed"
				ipv6_enable: true
			}]
		}
		peer_filters: [{
			name: "PF"
			sequence_numbers: [{
				sequence: 10
				match:    "as-range 64512-65535 result accept"
			}]
		}]
		router_bgp: {
			peer_groups: [{
				name: "PG"
				// workarounds for jinja2.exceptions.UndefinedError
				remove_private_as: {}
				remove_private_as_ingress: {}
				allowas_in: {}
				rib_in_pre_policy_retain: {}
				default_originate: {}
				link_bandwidth: {}
			}]
			router_id: _input.routerID
			as:        _input.local_context_data.bgp_asn
			neighbor_interfaces: [
				for _, intf in _input.local_context_data.bgp_intfs {
					{
						name:        intf
						peer_group:  "PG"
						peer_filter: "PF"
					}
				},
			]
			address_family_ipv4: {
				peer_groups: [{
					name:     "PG"
					activate: true
					next_hop: {
						address_family_ipv6_originate: true
					}
				}]
			}
			redistribute_routes: [{
				source_protocol: "connected"
			}]
			// workarounds for jinja2.exceptions.UndefinedError
			distance: {}
			maximum_paths: {}
			updates: {}
			bgp: bestpath: {}
		}

	}
}
