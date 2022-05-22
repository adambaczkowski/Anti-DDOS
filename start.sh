#!/bin/bash


echo "ALWAYS RUN AS SUDO!"
killall -s SIGTERM snort > /dev/null 2>&1
killall -s SIGTERM python3 > /dev/null 2>&1

sleep 1

trap "killall -s SIGTERM snort&& killall -s SIGTERM python3" SIGINT EXIT
 
IP_ADRESS=$(hostname -I | cut -f1 -d " ")
PORT=1337
LOGS_PATH="/home/pi/Anti-DDOS/logs.txt"

#python http server
sudo python3 -m http.server $PORT --bind $IP_ADRESS &

#snort
sudo snort -A console -q -u snort -g snort -c /etc/snort/snort.conf -i eth0 > $LOGS_PATH & 
