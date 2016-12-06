#!/bin/bash

for i in 1 2 3
do
	echo "Checking server for $i time"
	response=$(curl -Is http://127.0.0.1:9090 | head -1 | awk '{ print $2 }')
	
	if [ "$response" == "200" ]
	then
		echo "Tomcat Working Fine"
		break
	else
		echo "Tomcat Not Working Fine"
		if [ "$i" == "3" ]
        	then
			echo "Restarting Tomcat"
			service nginx stop			
			pkill tomcat		
			
			source=tomcat
			processIDs=$(ps -aef|grep "$source"|awk '{print $2}')
			echo $processIDs
			kill -9 $processIDs;

			echo "PAM Staging tomcat processes killed successfully" | mail -s "PAM Staging Tomcat processes Killed Successfully" -a "From: notify@securenow.in" mohit.virmani@oodlestechnologies.com kamaldeep.singh@oodlestechnologies.com prakhar.budholiya@oodlestechnologies.com
#echo "PAM Staging tomcat processes killed successfully" | mail -s "PAM Staging Tomcat processes Killed Successfully" -a "From: mohit.virmani@oodlestechnologies.com" prakhar.budholiya@oodlestechnologies.com

			sh /root/apache-tomcat-7.0.65/bin/startup.sh start
			
			#Start nginx if tomcat started successfully after 2 min
			sleep "120"
			testResponse=$(curl -Is http://127.0.0.1:9090 | head -1 | awk '{ print $2 }')
			echo "Tomcat status $testResponse"

			if [ "$testResponse" == "200" ]
			then
				service nginx restart
				echo "nginx started successfully"
				echo "PAM Staging tomcat server was restarted successfully" | mail -s "PAM Staging Server Restarted Successfully" -a "From: notify@securenow.in" mohit.virmani@oodlestechnologies.com prakhar.budholiya@oodlestechnologies.com kamaldeep.singh@oodlestechnologies.com
#echo "PAM Staging tomcat server was restarted successfully" | mail -s "PAM Staging Server Restarted Successfully" -a "From: mohit.virmani@oodlestechnologies.com" prakhar.budholiya@oodlestechnologies.com
			else
				echo "Tomcat Not yet up restarting script"
				source /root/autoScripts/autoRestartTomcat.sh
			fi
		fi
	fi
done


#service=/root/apache-tomcat-7.0.65/conf/logging.properties

##kill the service if HTTP headers does not return HTTP/1.1 200 OK
#response=$(curl -Is https://staging.securenowindia.com | head -1 | awk '{ print $2 }')
#echo $response
#if [ "$response" != "200" ]
#then
#echo "killing tomcat and java processes"
#pkill tomcat
##pkill java

##killing processes via process IDs
#source=tomcat
#processIDs=$(ps -aef|grep "$source"|awk '{print $2}')
#echo $processIDs
#kill -9 $processIDs;

#echo "PAM Staging tomcat processes killed successfully" | mail -s "PAM Staging Tomcat processes Killed Successfully" -a "From: notify@securenow.in" mohit.virmani@oodlestechnologies.com chetan.kumar@oodlestechnologies.com anurag.dhiman@oodlestechnologies.com ankit.uniyal@oodlestechnologies.com prakhar.budholiya@oodlestechnologies.com
##echo "PAM Staging tomcat processes killed successfully" | mail -s "PAM Staging Tomcat processes Killed Successfully" -a "From: mohit.virmani@oodlestechnologies.com" prakhar.budholiya@oodlestechnologies.com

#sh /root/apache-tomcat-7.0.65/bin/startup.sh start
#echo "PAM Staging tomcat server was restarted successfully" | mail -s "PAM Staging Server Restarted Successfully" -a "From: notify@securenow.in" mohit.virmani@oodlestechnologies.com chetan.kumar@oodlestechnologies.com anurag.dhiman@oodlestechnologies.com ankit.uniyal@oodlestechnologies.com prakhar.budholiya@oodlestechnologies.com
##echo "PAM Staging tomcat server was restarted successfully" | mail -s "PAM Staging Server Restarted Successfully" -a "From: mohit.virmani@oodlestechnologies.com" prakhar.budholiya@oodlestechnologies.com

#else
#echo "TOmcat all good  folks, nothing to do !"
#fi


#################################3





service=/root/staging/notify/notify-backend/appStag.js
num=$(ps -aef | grep -v grep | grep "$service" | wc -l | awk '{ print $0 }')
echo $num
if  [ $num -gt 0 ] ;

then

echo "server already up"
echo "$service is running!!!"

else

echo "starting node server"
#pkill node
#NODE_ENV=staging nohup node /root/staging/notify/notify-backend/appStag.js > /root/staging/notify/notify-backend/nohup.out &
#echo "PAM Staging Node server was restarted successfully" | mail -s "PAM Staging Node Server Restarted Successfully" -a "From: mohit.virmani@oodlestechnologies.com" mohit.virmani@oodlestechnologies.com chetan.kumar@oodlestechnologies.com anurag.dhiman@oodlestechnologies.com ankit.uniyal@oodlestechnologies.com

fi
