package schema

#config: {
	// loopback_interfaces
	loopback_interfaces?: [...{
		// mpls
		mpls?: {
			// ldp
			ldp?: {
				// interface
				interface?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}
			...
		}

		// ospf_area
		ospf_area?: (bool | null | number | string) & (null | bool | number | string)

		// name
		name?: (bool | null | number | string) & (null | bool | number | string)

		// isis_enable
		isis_enable?: (bool | null | number | string) & (null | bool | number | string)

		// vrf
		vrf?: (bool | null | number | string) & (null | bool | number | string)

		// ip_address
		ip_address?: (bool | null | number | string) & (null | bool | number | string)

		// node_segment
		node_segment?: {
			// ipv4_index
			ipv4_index?: (bool | null | number | string) & (null | bool | number | string)

			// ipv6_index
			ipv6_index?: (bool | null | number | string) & (null | bool | number | string)
			...
		}

		// shutdown
		shutdown?: ({
			...
		} | [...] | string | number | bool | null) & _

		// eos_cli
		eos_cli?: string

		// ipv6_address
		ipv6_address?: (bool | null | number | string) & (null | bool | number | string)

		// ipv6_enable
		ipv6_enable?: ({
			...
		} | [...] | string | number | bool | null) & _

		// isis_passive
		isis_passive?: ({
			...
		} | [...] | string | number | bool | null) & _

		// ip_address_secondaries
		ip_address_secondaries?: [...(bool | null | number | string) & (null | bool | number | string)]

		// ip_proxy_arp
		ip_proxy_arp?: ({
			...
		} | [...] | string | number | bool | null) & _

		// isis_network_point_to_point
		isis_network_point_to_point?: ({
			...
		} | [...] | string | number | bool | null) & _

		// description
		description?: (bool | null | number | string) & (null | bool | number | string)

		// isis_metric
		isis_metric?: (bool | null | number | string) & (null | bool | number | string)
		...
	}]

	// peer_filters
	peer_filters?: [...{
		// sequence_numbers
		sequence_numbers?: [...{
			// match
			match?: (bool | null | number | string) & (null | bool | number | string)

			// sequence
			sequence?: (bool | null | number | string) & (null | bool | number | string)
			...
		}]

		// name
		name?: (bool | null | number | string) & (null | bool | number | string)
		...
	}]

	// router_bgp
	router_bgp?: {
		// vpws
		vpws?: [...{
			// label_flow
			label_flow?: ({
				...
			} | [...] | string | number | bool | null) & _

			// mpls_control_word
			mpls_control_word?: ({
				...
			} | [...] | string | number | bool | null) & _

			// mtu
			mtu?: (bool | null | number | string) & (null | bool | number | string)

			// rd
			rd?: (bool | null | number | string) & (null | bool | number | string)

			// pseudowires
			pseudowires?: [...{
				// id_remote
				id_remote?: (bool | null | number | string) & (null | bool | number | string)

				// id_local
				id_local?: (bool | null | number | string) & (null | bool | number | string)

				// name
				name?: (bool | null | number | string) & (null | bool | number | string)
				...
			}]

			// route_targets
			route_targets?: {
				// import_export
				import_export?: (bool | null | number | string) & (null | bool | number | string)
				...
			}

			// name
			name?: (bool | null | number | string) & (null | bool | number | string)
			...
		}]

		// address_family_evpn
		address_family_evpn?: {
			// route
			route?: {
				// import_match_failure_action
				import_match_failure_action?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}

			// neighbor_default
			neighbor_default?: {
				// encapsulation
				encapsulation?: ({
					...
				} | [...] | string | number | bool | null) & _

				// next_hop_self_received_evpn_routes
				next_hop_self_received_evpn_routes?: {
					// inter_domain
					inter_domain?: ({
						...
					} | [...] | string | number | bool | null) & _

					// enable
					enable?: ({
						...
					} | [...] | string | number | bool | null) & _
					...
				}

				// next_hop_self_source_interface
				next_hop_self_source_interface?: string
				...
			}

			// domain_identifier
			domain_identifier?: (bool | null | number | string) & (null | bool | number | string)

			// peer_groups
			peer_groups?: [...{
				// route_map_in
				route_map_in?: (bool | null | number | string) & (null | bool | number | string)

				// activate
				activate?: ({
					...
				} | [...] | string | number | bool | null) & _

				// route_map_out
				route_map_out?: (bool | null | number | string) & (null | bool | number | string)

				// name
				name?: (bool | null | number | string) & (null | bool | number | string)

				// domain_remote
				domain_remote?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}]

			// evpn_hostflap_detection
			evpn_hostflap_detection?: {
				// enabled
				enabled?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}
			...
		}

		// bgp_defaults
		bgp_defaults?: [...(bool | null | number | string) & (null | bool | number | string)]

		// vlans
		vlans?: ({
			...
		} | [...] | string | number | bool | null) & _

		// peer_groups
		peer_groups?: [...{
			// route_map_in
			route_map_in?: (bool | null | number | string) & (null | bool | number | string)

			// maximum_routes
			maximum_routes?: string

			// send_community
			send_community?: ({
				...
			} | [...] | string | number | bool | null) & _

			// maximum_routes_warning_only
			maximum_routes_warning_only?: ({
				...
			} | [...] | string | number | bool | null) & _

			// next_hop_unchanged
			next_hop_unchanged?: ({
				...
			} | [...] | string | number | bool | null) & _

			// route_map_out
			route_map_out?: (bool | null | number | string) & (null | bool | number | string)

			// timers
			timers?: (bool | null | number | string) & (null | bool | number | string)

			// shutdown
			shutdown?: ({
				...
			} | [...] | string | number | bool | null) & _

			// rib_in_pre_policy_retain
			rib_in_pre_policy_retain?: {
				// all
				all?: ({
					...
				} | [...] | string | number | bool | null) & _

				// enabled
				enabled?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}

			// allowas_in
			allowas_in?: {
				// times
				times?: string

				// enabled
				enabled?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}

			// local_as
			local_as?: (bool | null | number | string) & (null | bool | number | string)

			// default_originate
			default_originate?: {
				// route_map
				route_map?: string

				// enabled
				enabled?: ({
					...
				} | [...] | string | number | bool | null) & _

				// always
				always?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}

			// maximum_routes_warning_limit
			maximum_routes_warning_limit?: string

			// description
			description?: (bool | null | number | string) & (null | bool | number | string)

			// bgp_listen_range_prefix
			bgp_listen_range_prefix?: (bool | null | number | string) & (null | bool | number | string)

			// update_source
			update_source?: (bool | null | number | string) & (null | bool | number | string)

			// weight
			weight?: (bool | null | number | string) & (null | bool | number | string)

			// bfd
			bfd?: ({
				...
			} | [...] | string | number | bool | null) & _

			// peer_filter
			peer_filter?: (bool | null | number | string) & (null | bool | number | string)

			// remove_private_as
			remove_private_as?: {
				// all
				all?: ({
					...
				} | [...] | string | number | bool | null) & _

				// replace_as
				replace_as?: ({
					...
				} | [...] | string | number | bool | null) & _

				// enabled
				enabled?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}

			// ebgp_multihop
			ebgp_multihop?: (bool | null | number | string) & (null | bool | number | string)

			// remote_as
			remote_as?: (bool | null | number | string) & (null | bool | number | string)

			// link_bandwidth
			link_bandwidth?: {
				// default
				default?: string

				// enabled
				enabled?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}

			// next_hop_self
			next_hop_self?: ({
				...
			} | [...] | string | number | bool | null) & _

			// password
			password?: (bool | null | number | string) & (null | bool | number | string)

			// name
			name?: string

			// route_reflector_client
			route_reflector_client?: ({
				...
			} | [...] | string | number | bool | null) & _

			// remove_private_as_ingress
			remove_private_as_ingress?: {
				// replace_as
				replace_as?: ({
					...
				} | [...] | string | number | bool | null) & _

				// enabled
				enabled?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}
			...
		}]

		// address_family_rtc
		address_family_rtc?: {
			// peer_groups
			peer_groups?: [...{
				// name
				name?: (bool | null | number | string) & (null | bool | number | string)

				// default_route_target
				default_route_target?: {
					// encoding_origin_as_omit
					encoding_origin_as_omit?: ({
						...
					} | [...] | string | number | bool | null) & _

					// only
					only?: ({
						...
					} | [...] | string | number | bool | null) & _
					...
				}

				// activate
				activate?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}]
			...
		}

		// vlan_aware_bundles
		vlan_aware_bundles?: [...{
			// no_redistribute_routes
			no_redistribute_routes?: [...(bool | null | number | string) & (null | bool | number | string)]

			// rd_evpn_domain
			rd_evpn_domain?: {
				// rd
				rd?: (bool | null | number | string) & (null | bool | number | string)

				// domain
				domain?: (bool | null | number | string) & (null | bool | number | string)
				...
			}

			// rd
			rd?: (bool | null | number | string) & (null | bool | number | string)

			// route_targets
			route_targets?: {
				// both
				both?: [...(bool | null | number | string) & (null | bool | number | string)]

				// import_evpn_domains
				import_evpn_domains?: [...{
					// route_target
					route_target?: (bool | null | number | string) & (null | bool | number | string)

					// domain
					domain?: (bool | null | number | string) & (null | bool | number | string)
					...
				}]

				// import
				import?: [...(bool | null | number | string) & (null | bool | number | string)]

				// export_evpn_domains
				export_evpn_domains?: [...{
					// route_target
					route_target?: (bool | null | number | string) & (null | bool | number | string)

					// domain
					domain?: (bool | null | number | string) & (null | bool | number | string)
					...
				}]

				// export
				export?: [...(bool | null | number | string) & (null | bool | number | string)]

				// import_export_evpn_domains
				import_export_evpn_domains?: [...{
					// route_target
					route_target?: (bool | null | number | string) & (null | bool | number | string)

					// domain
					domain?: (bool | null | number | string) & (null | bool | number | string)
					...
				}]
				...
			}

			// vlan
			vlan?: (bool | null | number | string) & (null | bool | number | string)

			// name
			name?: (bool | null | number | string) & (null | bool | number | string)

			// redistribute_routes
			redistribute_routes?: [...(bool | null | number | string) & (null | bool | number | string)]
			...
		}]

		// listen_ranges
		listen_ranges?: [...{
			// prefix
			prefix?: string

			// peer_filter
			peer_filter?: string

			// peer_id_include_router_id
			peer_id_include_router_id?: ({
				...
			} | [...] | string | number | bool | null) & _

			// peer_group
			peer_group?: string
			...
		}]

		// address_family_ipv6
		address_family_ipv6?: {
			// peer_groups
			peer_groups?: [...{
				// route_map_in
				route_map_in?: (bool | null | number | string) & (null | bool | number | string)

				// prefix_list_in
				prefix_list_in?: (bool | null | number | string) & (null | bool | number | string)

				// activate
				activate?: ({
					...
				} | [...] | string | number | bool | null) & _

				// prefix_list_out
				prefix_list_out?: (bool | null | number | string) & (null | bool | number | string)

				// route_map_out
				route_map_out?: (bool | null | number | string) & (null | bool | number | string)

				// name
				name?: (bool | null | number | string) & (null | bool | number | string)
				...
			}]

			// neighbors
			neighbors?: [...{
				// route_map_in
				route_map_in?: (bool | null | number | string) & (null | bool | number | string)

				// activate
				activate?: ({
					...
				} | [...] | string | number | bool | null) & _

				// ip_address
				ip_address?: (bool | null | number | string) & (null | bool | number | string)

				// prefix_list_out
				prefix_list_out?: (bool | null | number | string) & (null | bool | number | string)

				// route_map_out
				route_map_out?: (bool | null | number | string) & (null | bool | number | string)

				// prefix_list_in
				prefix_list_in?: (bool | null | number | string) & (null | bool | number | string)
				...
			}]

			// networks
			networks?: [...{
				// prefix
				prefix?: (bool | null | number | string) & (null | bool | number | string)

				// route_map
				route_map?: (bool | null | number | string) & (null | bool | number | string)
				...
			}]

			// redistribute_routes
			redistribute_routes?: [...{
				// route_map
				route_map?: string

				// source_protocol
				source_protocol?: string
				...
			}]
			...
		}

		// address_family_vpn_ipv6
		address_family_vpn_ipv6?: {
			// neighbors
			neighbors?: [...{
				// route_map_in
				route_map_in?: (bool | null | number | string) & (null | bool | number | string)

				// ip_address
				ip_address?: (bool | null | number | string) & (null | bool | number | string)

				// route_map_out
				route_map_out?: (bool | null | number | string) & (null | bool | number | string)

				// activate
				activate?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}]

			// route
			route?: {
				// import_match_failure_action
				import_match_failure_action?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}

			// peer_groups
			peer_groups?: [...{
				// route_map_in
				route_map_in?: (bool | null | number | string) & (null | bool | number | string)

				// name
				name?: (bool | null | number | string) & (null | bool | number | string)

				// route_map_out
				route_map_out?: (bool | null | number | string) & (null | bool | number | string)

				// activate
				activate?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}]

			// domain_identifier
			domain_identifier?: (bool | null | number | string) & (null | bool | number | string)

			// neighbor_default_encapsulation_mpls_next_hop_self
			neighbor_default_encapsulation_mpls_next_hop_self?: {
				// source_interface
				source_interface?: (bool | null | number | string) & (null | bool | number | string)
				...
			}
			...
		}

		// address_family_vpn_ipv4
		address_family_vpn_ipv4?: {
			// neighbors
			neighbors?: [...{
				// route_map_in
				route_map_in?: (bool | null | number | string) & (null | bool | number | string)

				// ip_address
				ip_address?: (bool | null | number | string) & (null | bool | number | string)

				// route_map_out
				route_map_out?: (bool | null | number | string) & (null | bool | number | string)

				// activate
				activate?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}]

			// route
			route?: {
				// import_match_failure_action
				import_match_failure_action?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}

			// peer_groups
			peer_groups?: [...{
				// route_map_in
				route_map_in?: (bool | null | number | string) & (null | bool | number | string)

				// name
				name?: (bool | null | number | string) & (null | bool | number | string)

				// route_map_out
				route_map_out?: (bool | null | number | string) & (null | bool | number | string)

				// activate
				activate?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}]

			// domain_identifier
			domain_identifier?: (bool | null | number | string) & (null | bool | number | string)

			// neighbor_default_encapsulation_mpls_next_hop_self
			neighbor_default_encapsulation_mpls_next_hop_self?: {
				// source_interface
				source_interface?: (bool | null | number | string) & (null | bool | number | string)
				...
			}
			...
		}

		// bgp
		bgp?: {
			// bestpath
			bestpath?: {
				// d_path
				d_path?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}
			...
		}

		// router_id
		router_id?: (bool | null | number | string) & (null | bool | number | string)

		// maximum_paths
		maximum_paths?: {
			// paths
			paths?: string

			// ecmp
			ecmp?: string
			...
		}

		// address_family_ipv4_multicast
		address_family_ipv4_multicast?: {
			// peer_groups
			peer_groups?: [...{
				// route_map_in
				route_map_in?: (bool | null | number | string) & (null | bool | number | string)

				// route_map_out
				route_map_out?: (bool | null | number | string) & (null | bool | number | string)

				// activate
				activate?: ({
					...
				} | [...] | string | number | bool | null) & _

				// name
				name?: (bool | null | number | string) & (null | bool | number | string)
				...
			}]

			// neighbors
			neighbors?: [...{
				// route_map_in
				route_map_in?: (bool | null | number | string) & (null | bool | number | string)

				// ip_address
				ip_address?: (bool | null | number | string) & (null | bool | number | string)

				// route_map_out
				route_map_out?: (bool | null | number | string) & (null | bool | number | string)

				// activate
				activate?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}]

			// redistribute_routes
			redistribute_routes?: [...{
				// route_map
				route_map?: string

				// source_protocol
				source_protocol?: string
				...
			}]
			...
		}

		// vrfs
		vrfs?: [...{
			// neighbors
			neighbors?: [...{
				// maximum_routes
				maximum_routes?: string

				// route_map_in
				route_map_in?: (bool | null | number | string) & (null | bool | number | string)

				// send_community
				send_community?: ({
					...
				} | [...] | string | number | bool | null) & _

				// maximum_routes_warning_only
				maximum_routes_warning_only?: ({
					...
				} | [...] | string | number | bool | null) & _

				// route_map_out
				route_map_out?: (bool | null | number | string) & (null | bool | number | string)

				// timers
				timers?: (bool | null | number | string) & (null | bool | number | string)

				// shutdown
				shutdown?: ({
					...
				} | [...] | string | number | bool | null) & _

				// rib_in_pre_policy_retain
				rib_in_pre_policy_retain?: {
					// all
					all?: ({
						...
					} | [...] | string | number | bool | null) & _

					// enabled
					enabled?: ({
						...
					} | [...] | string | number | bool | null) & _
					...
				}

				// peer_group
				peer_group?: (bool | null | number | string) & (null | bool | number | string)

				// allowas_in
				allowas_in?: {
					// times
					times?: string

					// enabled
					enabled?: ({
						...
					} | [...] | string | number | bool | null) & _
					...
				}

				// local_as
				local_as?: (bool | null | number | string) & (null | bool | number | string)

				// ip_address
				ip_address?: string

				// prefix_list_out
				prefix_list_out?: (bool | null | number | string) & (null | bool | number | string)

				// default_originate
				default_originate?: {
					// route_map
					route_map?: string

					// always
					always?: ({
						...
					} | [...] | string | number | bool | null) & _
					...
				}

				// maximum_routes_warning_limit
				maximum_routes_warning_limit?: string

				// description
				description?: (bool | null | number | string) & (null | bool | number | string)

				// update_source
				update_source?: (bool | null | number | string) & (null | bool | number | string)

				// weight
				weight?: (bool | null | number | string) & (null | bool | number | string)

				// bfd
				bfd?: ({
					...
				} | [...] | string | number | bool | null) & _

				// remove_private_as
				remove_private_as?: {
					// all
					all?: ({
						...
					} | [...] | string | number | bool | null) & _

					// replace_as
					replace_as?: ({
						...
					} | [...] | string | number | bool | null) & _

					// enabled
					enabled?: ({
						...
					} | [...] | string | number | bool | null) & _
					...
				}

				// ebgp_multihop
				ebgp_multihop?: string

				// prefix_list_in
				prefix_list_in?: (bool | null | number | string) & (null | bool | number | string)

				// remote_as
				remote_as?: (bool | null | number | string) & (null | bool | number | string)

				// next_hop_self
				next_hop_self?: ({
					...
				} | [...] | string | number | bool | null) & _

				// password
				password?: (bool | null | number | string) & (null | bool | number | string)

				// remove_private_as_ingress
				remove_private_as_ingress?: {
					// replace_as
					replace_as?: ({
						...
					} | [...] | string | number | bool | null) & _

					// enabled
					enabled?: ({
						...
					} | [...] | string | number | bool | null) & _
					...
				}
				...
			}]

			// networks
			networks?: [...{
				// prefix
				prefix?: (bool | null | number | string) & (null | bool | number | string)

				// route_map
				route_map?: (bool | null | number | string) & (null | bool | number | string)
				...
			}]

			// evpn_multicast
			evpn_multicast?: ({
				...
			} | [...] | string | number | bool | null) & _

			// rd
			rd?: (bool | null | number | string) & (null | bool | number | string)

			// timers
			timers?: (bool | null | number | string) & (null | bool | number | string)

			// neighbor_interfaces
			neighbor_interfaces?: [...{
				// remote_as
				remote_as?: (bool | null | number | string) & (null | bool | number | string)

				// name
				name?: (bool | null | number | string) & (null | bool | number | string)

				// peer_group
				peer_group?: (bool | null | number | string) & (null | bool | number | string)
				...
			}]

			// route_targets
			route_targets?: {
				// import
				import?: [...{
					// address_family
					address_family?: (bool | null | number | string) & (null | bool | number | string)

					// route_targets
					route_targets?: [...(bool | null | number | string) & (null | bool | number | string)]
					...
				}]

				// export
				export?: [...{
					// address_family
					address_family?: (bool | null | number | string) & (null | bool | number | string)

					// route_targets
					route_targets?: [...(bool | null | number | string) & (null | bool | number | string)]
					...
				}]
				...
			}

			// aggregate_addresses
			aggregate_addresses?: [...{
				// as_set
				as_set?: ({
					...
				} | [...] | string | number | bool | null) & _

				// attribute_map
				attribute_map?: string

				// summary_only
				summary_only?: ({
					...
				} | [...] | string | number | bool | null) & _

				// advertise_only
				advertise_only?: ({
					...
				} | [...] | string | number | bool | null) & _

				// prefix
				prefix?: string

				// match_map
				match_map?: string
				...
			}]

			// name
			name?: (bool | null | number | string) & (null | bool | number | string)

			// listen_ranges
			listen_ranges?: [...{
				// prefix
				prefix?: string

				// peer_filter
				peer_filter?: string

				// peer_id_include_router_id
				peer_id_include_router_id?: ({
					...
				} | [...] | string | number | bool | null) & _

				// peer_group
				peer_group?: string
				...
			}]

			// router_id
			router_id?: (bool | null | number | string) & (null | bool | number | string)

			// eos_cli
			eos_cli?: string

			// address_families
			address_families?: [...{
				// neighbors
				neighbors?: [...{
					// route_map_in
					route_map_in?: (bool | null | number | string) & (null | bool | number | string)

					// ip_address
					ip_address?: (bool | null | number | string) & (null | bool | number | string)

					// route_map_out
					route_map_out?: (bool | null | number | string) & (null | bool | number | string)

					// activate
					activate?: ({
						...
					} | [...] | string | number | bool | null) & _
					...
				}]

				// networks
				networks?: [...{
					// prefix
					prefix?: string

					// route_map
					route_map?: string
					...
				}]

				// address_family
				address_family?: (bool | null | number | string) & (null | bool | number | string)

				// peer_groups
				peer_groups?: [...{
					// next_hop
					next_hop?: {
						// address_family_ipv6_originate
						address_family_ipv6_originate?: ({
							...
						} | [...] | string | number | bool | null) & _
						...
					}

					// activate
					activate?: ({
						...
					} | [...] | string | number | bool | null) & _

					// name
					name?: (bool | null | number | string) & (null | bool | number | string)
					...
				}]

				// bgp
				bgp?: {
					// additional_paths
					additional_paths?: [...(bool | null | number | string) & (null | bool | number | string)]

					// missing_policy
					missing_policy?: {
						// direction_out_action
						direction_out_action?: (bool | null | number | string) & (null | bool | number | string)

						// direction_in_action
						direction_in_action?: (bool | null | number | string) & (null | bool | number | string)
						...
					}
					...
				}
				...
			}]

			// redistribute_routes
			redistribute_routes?: [...{
				// route_map
				route_map?: string

				// source_protocol
				source_protocol?: string
				...
			}]
			...
		}]

		// distance
		distance?: {
			// external_routes
			external_routes?: string

			// internal_routes
			internal_routes?: string

			// local_routes
			local_routes?: string
			...
		}

		// as
		as?: (bool | null | number | string) & (null | bool | number | string)

		// updates
		updates?: {
			// wait_for_convergence
			wait_for_convergence?: ({
				...
			} | [...] | string | number | bool | null) & _

			// wait_install
			wait_install?: ({
				...
			} | [...] | string | number | bool | null) & _
			...
		}

		// neighbors
		neighbors?: [...{
			// route_map_in
			route_map_in?: (bool | null | number | string) & (null | bool | number | string)

			// maximum_routes
			maximum_routes?: string

			// send_community
			send_community?: ({
				...
			} | [...] | string | number | bool | null) & _

			// maximum_routes_warning_only
			maximum_routes_warning_only?: ({
				...
			} | [...] | string | number | bool | null) & _

			// route_map_out
			route_map_out?: (bool | null | number | string) & (null | bool | number | string)

			// timers
			timers?: (bool | null | number | string) & (null | bool | number | string)

			// shutdown
			shutdown?: ({
				...
			} | [...] | string | number | bool | null) & _

			// rib_in_pre_policy_retain
			rib_in_pre_policy_retain?: {
				// all
				all?: ({
					...
				} | [...] | string | number | bool | null) & _

				// enabled
				enabled?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}

			// peer_group
			peer_group?: (bool | null | number | string) & (null | bool | number | string)

			// allowas_in
			allowas_in?: {
				// times
				times?: string

				// enabled
				enabled?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}

			// local_as
			local_as?: (bool | null | number | string) & (null | bool | number | string)

			// ip_address
			ip_address?: string

			// default_originate
			default_originate?: {
				// route_map
				route_map?: string

				// enabled
				enabled?: ({
					...
				} | [...] | string | number | bool | null) & _

				// always
				always?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}

			// maximum_routes_warning_limit
			maximum_routes_warning_limit?: string

			// description
			description?: (bool | null | number | string) & (null | bool | number | string)

			// update_source
			update_source?: (bool | null | number | string) & (null | bool | number | string)

			// weight
			weight?: (bool | null | number | string) & (null | bool | number | string)

			// bfd
			bfd?: ({
				...
			} | [...] | string | number | bool | null) & _

			// remove_private_as
			remove_private_as?: {
				// all
				all?: ({
					...
				} | [...] | string | number | bool | null) & _

				// replace_as
				replace_as?: ({
					...
				} | [...] | string | number | bool | null) & _

				// enabled
				enabled?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}

			// ebgp_multihop
			ebgp_multihop?: (bool | null | number | string) & (null | bool | number | string)

			// remote_as
			remote_as?: (bool | null | number | string) & (null | bool | number | string)

			// link_bandwidth
			link_bandwidth?: {
				// default
				default?: string

				// enabled
				enabled?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}

			// next_hop_self
			next_hop_self?: ({
				...
			} | [...] | string | number | bool | null) & _

			// password
			password?: (bool | null | number | string) & (null | bool | number | string)

			// remove_private_as_ingress
			remove_private_as_ingress?: {
				// replace_as
				replace_as?: ({
					...
				} | [...] | string | number | bool | null) & _

				// enabled
				enabled?: ({
					...
				} | [...] | string | number | bool | null) & _
				...
			}
			...
		}]

		// address_family_ipv4
		address_family_ipv4?: {
			// peer_groups
			peer_groups?: [...{
				// route_map_in
				route_map_in?: (bool | null | number | string) & (null | bool | number | string)

				// prefix_list_in
				prefix_list_in?: (bool | null | number | string) & (null | bool | number | string)

				// next_hop
				next_hop?: {
					// address_family_ipv6_originate
					address_family_ipv6_originate?: ({
						...
					} | [...] | string | number | bool | null) & _
					...
				}

				// activate
				activate?: ({
					...
				} | [...] | string | number | bool | null) & _

				// prefix_list_out
				prefix_list_out?: (bool | null | number | string) & (null | bool | number | string)

				// route_map_out
				route_map_out?: (bool | null | number | string) & (null | bool | number | string)

				// default_originate
				default_originate?: {
					// route_map
					route_map?: string

					// always
					always?: ({
						...
					} | [...] | string | number | bool | null) & _
					...
				}

				// name
				name?: string
				...
			}]

			// neighbors
			neighbors?: [...{
				// route_map_in
				route_map_in?: (bool | null | number | string) & (null | bool | number | string)

				// activate
				activate?: ({
					...
				} | [...] | string | number | bool | null) & _

				// ip_address
				ip_address?: string

				// prefix_list_out
				prefix_list_out?: (bool | null | number | string) & (null | bool | number | string)

				// route_map_out
				route_map_out?: (bool | null | number | string) & (null | bool | number | string)

				// default_originate
				default_originate?: {
					// route_map
					route_map?: string

					// always
					always?: ({
						...
					} | [...] | string | number | bool | null) & _
					...
				}

				// prefix_list_in
				prefix_list_in?: (bool | null | number | string) & (null | bool | number | string)
				...
			}]

			// networks
			networks?: [...{
				// prefix
				prefix?: (bool | null | number | string) & (null | bool | number | string)

				// route_map
				route_map?: (bool | null | number | string) & (null | bool | number | string)
				...
			}]
			...
		}

		// aggregate_addresses
		aggregate_addresses?: [...{
			// as_set
			as_set?: ({
				...
			} | [...] | string | number | bool | null) & _

			// attribute_map
			attribute_map?: string

			// summary_only
			summary_only?: ({
				...
			} | [...] | string | number | bool | null) & _

			// advertise_only
			advertise_only?: ({
				...
			} | [...] | string | number | bool | null) & _

			// prefix
			prefix?: string

			// match_map
			match_map?: string
			...
		}]

		// neighbor_interfaces
		neighbor_interfaces?: [...{
			// remote_as
			remote_as?: (bool | null | number | string) & (null | bool | number | string)

			// name
			name?: (bool | null | number | string) & (null | bool | number | string)

			// peer_group
			peer_group?: (bool | null | number | string) & (null | bool | number | string)
			...
		}]

		// bgp_cluster_id
		bgp_cluster_id?: (bool | null | number | string) & (null | bool | number | string)

		// redistribute_routes
		redistribute_routes?: [...{
			// route_map
			route_map?: string

			// source_protocol
			source_protocol?: string
			...
		}]
		...
	}
	...
}
