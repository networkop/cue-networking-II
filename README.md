# CUE for Network Automation (Part II)


## Walkthrough

1. Pre-seed `demo.nautobot.com` with test data

```
cue apply ./...
```

2. Retrieve device data from Nautobot and save it as a set of host variables

```
cue fetch ./...
```

3. Print per-device structured configurations

```
cue try ./...
```

4. Print final device configurations

```
cue show ./...
```

4. Apply network configurations


```
cue push ./...
```

6. Cleanup `demo.nautobot.com`

```
cue cleanup ./...
```

## Creating CUE schemas

### Option 1 - from Jinja templates

1. Download the required Jinja templates and put them in the `./schemas/<vendor>` directory.

```
cat schemas/arista/eos.conf_original.j2
```

2. Remove all custom filters from a copy of each template.

```
cp arista/eos.conf_original.j2 arista/eos.conf.j2
sed -E -i 's/\|\s+arista\.avd\.\S+//' arista/eos.conf.j2
sed -E -i 's/arista.avd.defined/defined/g' arista/eos.conf.j2
sed -i -E 's/defined\(true\)/defined/' schemas/arista/eos.conf.j2
sed -i -E 's/defined\(false\)/defined/' schemas/arista/eos.conf.j2
sed -i -E 's/defined\(\'all\'\)/defined/' schemas/arista/eos.conf.j2
```

3. Convert Jinja templates to a JSON schema

```
$ pip install jinja2schema
$ ./jinja-to-json-schema.py arista/eos.conf.j2
```

4. Convert JSON schema into CUE

```
cue import -f -p schema schema.json -o arista/schema.cue
```

5. (Optional) Make all fields optional

```
sed -i -E 's/(\s+\w+):/\1\?\:/' schemas/arista/schema.cue
```

### Option 2 - from YAML files

1. Get a copy of target device configuration in YAML format

```
cat schemas/nvidia/config.yml
```

2. Generate a JSON schema from the YAML file

```
cat schemas/nvidia/schema.json
```

3. Import as CUE 

```
cue import -f -p schema nvidia/schema.json
```

4. Cleanup the schema (remove concrete values and add constraints)

```diff
< import "net"
<
---
> @jsonschema(schema="http://json-schema.org/draft-06/schema#")
> _
12c12,15
< #Interface: [string]: #InterfaceClass
---
> #Interface: {
>       lo:   #Lo
>       swp1: #InterfaceSwp1
> }
14,15c17,18
< #InterfaceClass: {
<       ip?:   #IP
---
> #Lo: {
>       ip:   #IP
19c22,30
< #IP: address: [string & net.IPCIDR]: {}
---
> #IP: address: #Address
>
> #Address: "198.51.100.1/32": #["198.51.100.132"]
>
> #: "198.51.100.132": {
>       ...
> }
>
> #InterfaceSwp1: type: string
48c59
< #Neighbor: [string]: #NeighborClass
---
> #Neighbor: swp1: #NeighborSwp1
50c61
< #NeighborClass: {
---
> #NeighborSwp1: {
```

## Working with Jinja (j2cli)

1. Install `j2cli`

```
pip install j2cli
```

1. Download any custom Jinja filters and test into the `./jinja` directory. 

```tree
tree jinja
jinja
├── filters
│   └── combined.py
└── tests
    └── defined.py
```

2. Rename custom filters to get rid of namespacing

```
sed -E -i 's/arista.avd./arista_avd_/g' arista/eos.conf_original.j2
```

3. Update Python functions inside `./jinja` directory to match the new naming scheme

4. Pass updated python files as arguments to `j2cli`

```
j2 --tests jinja/tests/defined.py --filters jinja/filters/combined.py -f json schemas/arista/eos.conf_original.j2 -
```

## Building the lab

Build the lab topology using containerlab:

```
cd lab;
sudo containerlab -t two-node.yml
```

If running on WSL2, adjust the default iptables rules

```
docker exec lon-sw-02 ip6tables -P INPUT ACCEPT
docker exec lon-sw-02 ip6tables -P FORWARD ACCEPT
docker exec lon-sw-02 iptables -P FORWARD ACCEPT
docker exec lon-sw-02 iptables -P INPUT ACCEPT
```