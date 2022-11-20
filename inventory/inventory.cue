package inventory

auth: {
	nvidia: {
		user:     *"cumulus" | string @tag(NVIDIA_USER)
		password: *"cumulus" | string @tag(NVIDIA_PASSWORD)
	}
	arista: {
		user:     *"admin" | string @tag(ARISTA_USER)
		password: *"admin" | string @tag(ARISTA_PASSWORD)
	}
}

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
	user:     auth.nvidia.user
	password: auth.nvidia.password
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
	user:     auth.arista.user
	password: auth.arista.password
}]

ipam: {
	url:   *"https://demo.nautobot.com/api" | string            @tag(IPAM_URL)
	token: *"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" | string @tag(IPAM_TOKEN)
	headers: header: {
		"Authorization": "Token \(token)"
		"Accept":        "application/json"
		"Content-Type":  "application/json"
	}
}
