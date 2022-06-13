#!/bin/bash
access_log_file=/home/pi/Anti-DDOS/logs.txt
installed_dir=/home/pi/Anti-DDOS
lines_check=100
ddos_sign_grep=404
max_ddos_requested=12  

sudo tail -n $lines_check $access_log_file |grep -E $ddos_sign_grep|cut -f 1 -d ' '|sort|uniq -c|sort -nr > $output_checked_file

filename=$output_checked_file
n=1
IFS=' '

while read line; do
	read -a strarr <<< "$line"
	#echo "Line No. $n : Count: ${strarr[0]} - IP: ${strarr[1]}"
	
	#ufw ->mail
	if [ ${strarr[0]} -ge $max_ddos_requested ]
    then
        #echo "Found DDOS IP: Count: ${strarr[0]} - IP: ${strarr[1]}"
		if sudo ufw insert 2 deny from ${strarr[1]} | grep -q 'Rule inserted'; then
			echo "${strarr[1]}" >> $ips_to_ufw_logs
			#echo "DDOS IP Blocked: ${strarr[1]} !" | mail -s "$app_name: DDOS Blocked "$(date +"%Y-%m-%d_%H_%M_%S") your_admin@gmail.com
		fi		
	fi
	n=$((n+1))
done < $filename
