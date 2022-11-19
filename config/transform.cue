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
				(intf.name): {
					ip: address: (intf.ip_addresses[0].address): {}
					if strings.HasPrefix(intf.name, "loopback") {
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
				neighbor: [intf]: {
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
        for _, intf in _input.interfaces {
            if strings.HasPrefix(intf.name, "loopback") {
                loopback_interfaces: [{
                    name: intf.name
                    ip_address: intf.ip_addresses[0].address
                    // workarounds for custom Jinja filters
                    ip_address_secondaries: []
                    mpls: ldp: {}
                    node_segment: {}
                }]
            }
        }
        peer_filters: [{
            name: "PF"
            sequence_numbers: [{
                sequence: "result accept"
                match: "64512-65535"
            }]
        }]
        router_bgp: {
            peer_groups: [{
                name: "PG"
                // workarounds for custom Jinja filters
                remove_private_as: {}
                remove_private_as_ingress: {}
                allowas_in: {}
                rib_in_pre_policy_retain: {}
                default_originate: {}
                link_bandwidth: {}
            }]
            router_id: _input.routerID
            as: _input.local_context_data.bgp_asn
            neighbor_interfaces: [
                for _, intf in _input.local_context_data.bgp_intfs {
                    {
                        name: intf
                        peer_group: "PG"
                        peer_filter: "PF"
                    }
                }
            ]
            address_family_ipv4: {
                peer_groups: [{
                    name: "PG"
                    activate: true
                    next_hop: {
                        address_family_ipv6_originate: true
                    }
                }]
                // workarounds for custom Jinja filters
                neighbors: []
                networks: []
            }
            // workarounds for custom Jinja filters
            neighbors: [{
                remove_private_as: {}
                remove_private_as_ingress: {}
                allowas_in: {}
                rib_in_pre_policy_retain: {}
                default_originate: {}
                link_bandwidth: {}
            }]
            aggregate_addresses: [{
                prefix: ""
            }]
            redistribute_routes: [{}]
            vlan_aware_bundles: [{
                name: ""
                rd_evpn_domain: {}
                route_targets: {
                    both: []
                    import: []
                    export: []
                    import_evpn_domains: []
                    export_evpn_domains: []
                    import_export_evpn_domains: []
                }
                redistribute_routes: []
                no_redistribute_routes: []
                vlan: ""
            }]
            distance: {}
            maximum_paths: {}
            updates: {}
            bgp_defaults: []
            bgp: bestpath: {}
            vrfs: []
        }
        
    }
}
