# poma-secscan
a poor man's security scan

This tool does some very basic security config check that can run fast
and give a first impression on the cyber hygiene of a web presence.

Following scans are currently supported:

* cookie scan: scans for secure and httpOnly flags of cookies (using selenium to catch JS ones)
* port scan: scans (fast) for common open ports

```
usage: ./poma.sh [-c] [-p] <host>
-c|--cookie run cookie scan to test for secure and httpOnly flags
-p|--ports run fast port scan
<host> the host such as www.microspot.ch (without the protocol such as http)
```

# Requirements

## Cookie Scan (-c option)
* python3
* geckodriver from https://github.com/mozilla/geckodriver/releases
* python3-selenium

## Portscan (-p option)
* nmap

# Config File

You can write a config file called poma.config which must be placed in
the same directory as poma.sh. Currently there is only one option to
be set in there:

* geckodriver=/full/path/to/geckodriver/incl/binary (default: in the same directory as poma.sh)

If there is no config file, the script will fall back to defaults