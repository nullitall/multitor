!/bin/bash


rm -rf data 
killall tor
set -e

base_socks_port=9050

# Create data directory if it doesn't exist
if [ ! -d "data" ]; then
        mkdir "data"
fi

TOR_INSTANCES="$1"
#change to your ip address
ip_addr=192.168.1.15
for i in $(seq $TOR_INSTANCES)
do
        j=$((i+1))
        socks_port=$((base_socks_port+i))
        if [ ! -d "/home/USERNAME/data/tor$i" ]; then
                echo "Creating directory data/tor$i"
                mkdir "/home/USERNAME/data/tor$i"
        fi

        # Take into account that authentication for the control port is disabled. Must be used in secure and controlled environments

        tor --RunAsDaemon 1 --CookieAuthentication 0 --PidFile /home/USERNAME/data/tor$i.pid --SocksPort $ip_addr:$socks_port --DataDirectory /home/USERNAME/data/tor$i
done
