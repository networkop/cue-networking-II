package schema

import "net"


#set: {
	interface: #Interface
	router:    #Router
	vrf:       #Vrf
}

#Interface: [string]: #InterfaceClass

#InterfaceClass: {
	ip?:   #IP
	type: string
}

#IP: address: [string & net.IPCIDR]: {}

#Router: bgp: #ConnectedClass

#ConnectedClass: enable: string

#Vrf: default: #Default

#Default: router: #DefaultRouter

#DefaultRouter: bgp: #BGP

#BGP: {
	"address-family":    #AddressFamily
	"autonomous-system": int
	enable:              string
	neighbor:            #Neighbor
	"router-id":         string
}

#AddressFamily: "ipv4-unicast": #Ipv4Unicast

#Ipv4Unicast: {
	enable:       string
	redistribute: #Redistribute
}

#Redistribute: connected: #ConnectedClass

#Neighbor: [string]: #NeighborClass

#NeighborClass: {
	"remote-as": string
	type:        string
}
