package inventory

#devices: [{
	name:     "lon-sw-01"
	vendor:   "NVIDIA1"
	type:     "SN4700"
	role:     "lleaf"
	site:     "LON1"
	status:   "Active"
	asn:      65000
	loopback: "198.51.100.1/32"
	uplinks: ["swp1"]
}, {
	name:     "lon-sw-02"
	vendor:   "Arista1"
	type:     "7050X3"
	role:     "sspine"
	site:     "LON2"
	status:   "Active"
	asn:      65001
	loopback: "198.51.100.2/32"
	uplinks: ["Ethernet1"]
}]

ipam: {
	url:   *"https://demo.nautobot.com/api" | string            @tag(ipamURL)
	token: *"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" | string @tag(ipamToken)
	headers: header: {
		"Authorization": "Token \(token)"
		"Accept":        "application/json"
		"Content-Type":  "application/json"
	}
}
