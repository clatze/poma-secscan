#!/bin/bash

# some functions

usage()
{
    echo "usage: ./poma.sh [-c] [-p] <host>"
    echo "-c|--cookie run cookie scan to test for secure and httpOnly flags"
    echo "-p|--ports run fast port scan"
    echo "-s|--spf check for SPF record"
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
    if [ -z $geckodriver ]
    then
	echo "ERROR: config variable geckodriver not set"
	exit 1
    fi
else
    echo "no $CONFIG found, falling back to default values "
    geckodriver="`pwd`/geckodriver"
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
    dig txt $host | grep spf
    echo "checking for SPF record done"
fi

