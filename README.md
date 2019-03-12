# poma-secscan
a poor man's security scan

This tool does some very basic security config check that can run fast
and give a first impression on the cyber hygiene of a web presence.

Following scans are currently supported:

* cookie scan: scans for secure and httpOnly flags of cookies (using selenium to catch JS ones)
* port scan: scans (fast) for common open ports
* spf record: check if spf record is set for domain

```
usage: ./poma.sh [-c] [-p] <host>
-c|--cookie run cookie scan to test for secure and httpOnly flags
-p|--ports run fast port scan
-s|--spf check for SPF record
-t|--tls check for TLS settings
<host> the host such as www.microspot.ch (without the protocol such as http)
```

# Requirements

## Cookie Scan (-c option)
* python3
* geckodriver from https://github.com/mozilla/geckodriver/releases
* python3-selenium

## Portscan (-p option)
* nmap

## SPF check (-s option)
* dig

# TLS check (-t option)
* testssl from https://testssl.sh

# Config File

You can write a config file called *poma.config* which must be placed in
the same directory as poma.sh. Those are the options that can be set
here:

* geckodriver=/full/path/to/geckodriver/incl/binary (default: in the same directory as poma.sh)
* dnsserver=<ip of dns server, e.g. 9.9.9.9> (default: system dns)
* testssl_dir=/full/path/where/testssl.sh/is/located (default: the same directory where poma.sh is located)

If there is no config file, the script will fall back to
defaults. Same applies to options that are missing from the config
file