#!/bin/bash



# accept cmdline params

usage()
{
    echo "usage: ./poma.sh [-c] <host>"
    echo "-c|--cookie run cookie scan to test for secure and httpOnly flags"
}

if [ $# -lt 1 ]
then
    usage
    exit 1
fi

for i in "${@}"
do
    case $i in
	-c|--cookie)
	    cookie=1
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

echo $geckodriver

###


if [ $cookie -eq 1 ]
then
    echo "cookie scan starting on $host"
    python3 analyze_cookies.py $geckodriver $host
    echo "cookie scan done"
fi

