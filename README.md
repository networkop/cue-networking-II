# CUE for Network Automation (Part 2)


## Walkthrough

1. Pre-seed `demo.nautobot.com` with test data

```
cue apply ./...
```

2. Retrieve device data from Nautobot and save it as a set of host variables

```
cue fetch ./...
```

3. Print generated per-device structured configurations

```
cue try ./...
```

4. Apply network configurations


```
cue push ./...
```