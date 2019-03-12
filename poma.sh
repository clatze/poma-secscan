#!/bin/bash

# some functions

usage()
{
    echo "usage: ./poma.sh [-c] [-p] <host>"
    echo "-c|--cookie run cookie scan to test for secure and httpOnly flags"
    echo "-p|--ports run fast port scan"
    echo "-s|--spf check for SPF record"
    echo "-t|--tls check for TLS settings"
    echo "<host> the host such as www.microspot.ch (without the protocol such as http)"
}


printSeperator()
{
    echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
}


####

if [ $# -lt 2 ] # at least one option and a host
then
    usage
    exit 1
fi

cookie=0
ports=0
spf=0
tls=0

for i in "${@}"
do
    case $i in
	-c|--cookie)
	    cookie=1
	    ;;
	-p|--ports)
	    ports=1
	    ;;
	-s|--spf)
	    spf=1
	    ;;
	-t|--tls)
	    tls=1
	    ;;
	*)
	    if [ $i != ${!#} ] #there is certainly a better way to exclude host here
	    then
		usage
		exit 1
	    fi
	    ;;
    esac
done

host=${!#}

# read some few params from a config file, if that does not exist, fall back to default values
CONFIG=poma.config
if [ -f $CONFIG ]
then
    . ./$CONFIG
fi

if [ -z $geckodriver ]
then
    geckodriver="`pwd`/geckodriver"
fi

if [ -z $testssl_dir ]
then
    testssl_dir="`pwd`"
fi

###


if [ $cookie -eq 1 ]
then
    printSeperator
    echo "cookie scan starting on $host"
    python3 analyze_cookies.py $geckodriver "http://"$host
    echo "cookie scan done"
fi


if [ $ports -eq 1 ]
then
    printSeperator
    echo "fast portscan starting on $host"
    nmap -F $host
    echo "fast portscan done"
fi

if [ $spf -eq 1 ]
then
    printSeperator
    echo "checking for SPF record on $host"
    if [ -z $dnsserver ]
    then
	dig txt $host | grep spf
    else
	dig @$dnsserver txt $host | grep spf
    fi
    echo "checking for SPF record done"
fi

if [ $tls -eq 1 ]
then
    printSeperator
    echo "checking for TLS settings on $host"
    $testssl_dir"/testssl.sh" $host
    echo "checking for TLS settings done"
fi
