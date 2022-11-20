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

## Working with Jinja templates

1. Download or create your own Jinja template and put it in the `./templates/` directory

A bit of sed-foo to remove custom filters and standardise Jinja:

```
sed -E -i 's/arista.avd./arista_avd_/g' arista/eos.conf.j2
```


2. Convert Jinja template to a JSON schema

```
$ pip install jinja2schema
$ ./jinja-to-json-schema.py arista/eos.conf.j2
```

3. Convert JSON schema into CUE

```
cue import -f -p schema schema.json -o arista/schema.cue
```
Make all fields optional
```
sed -i -E 's/(\s+\w+):/\1\?\:/' schemas/arista/schema.cue
```

4. For NVIDIA, first generate a JSON schema

5. Import as CUE 


```
cue import -f -p schema nvidia/schema.json
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