#!/bin/bash
search_dir=/home/pi/Anti-DDOS/add_ufw_logs
today_ips_to_ufw_logs=ufw_ddos_ip_$(date +"%Y-%m-%d").txt

if [  "$(ls -A $search_dir)" ]
then
	for ip_ufw_log_file in "$search_dir"/*
	do
			#echo "$ip_ufw_log_file"

			#found old files
			if [ "$ip_ufw_log_file" != "$search_dir/$today_ips_to_ufw_logs" ]; then
					echo "$ip_ufw_log_file"

					#read blocked IPs
					while read line; do
							# reading each line
							echo "Blocked IP : $line"
							#remove blocked IPs from UFW rules
							sudo ufw delete deny from $line
					done < $ip_ufw_log_file
					#delete old file
					rm -rf $ip_ufw_log_file
			fi
	done

fi

