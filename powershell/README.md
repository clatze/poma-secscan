# poma-secscan
a poor man's security scan

This tool does some very basic security config check that can run fast
and give a first impression on the cyber hygiene of a web presence.

This version focuses on very simple Powershell scripts and commands that should be available everywhere.

## Scan for an open port

```
Test-NetConnection -ComputerName <host> -Port <port>
```
Corporate networks might only allow 80 and 443 to pass no matter which ports are really open on the other side.

## Analyse headers

```
$r = Invoke-WebRequest <host>
$r.Headers
$r.BaseResponse
$r.Forms
$r.Images
$r.InputFields
$r.Links
$r.StatusCode
```
## DNS Records

```
Resolve-DnsName -Name <host>
Resolve-DnsName -Name <host> -Type TXT
```

# TODO

* check for JS changes
* check for cookies
* check for certificates and chains
* check for subdomains