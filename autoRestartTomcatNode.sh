#!/bin/bash

service=/root/apache-tomcat-7.0.65/conf/logging.properties

#kill the service if HTTP headers does not return HTTP/1.1 200 OK
response=$(curl -Is http://staging.securenowindia.com:9090 | head -1 | awk '{ print $2 }')
echo $response
if [ "$response" != "200" ]
then
echo "killing tomcat and java processes"
pkill tomcat
pkill java

#killing processes via process IDs
source=tomcat
processIDs=$(ps -aef|grep "$source"|awk '{print $2}')
echo $processIDs
kill -9 $processIDs;

echo "PAM Staging tomcat processes killed successfully" | mail -s "PAM Staging Tomcat processes Killed Successfully" -a "From: mohit.virmani@oodlestechnologies.com" mohit.virmani@oodlestechnologies.com chetan.kumar@oodlestechnologies.com anurag.dhiman@oodlestechnologies.com ankit.uniyal@oodlestechnologies.com

sh /root/apache-tomcat-7.0.65/bin/startup.sh start
echo "PAM Staging tomcat server was restarted successfully" | mail -s "PAM Staging Server Restarted Successfully" -a "From: mohit.virmani@oodlestechnologies.com" mohit.virmani@oodlestechnologies.com chetan.kumar@oodlestechnologies.com anurag.dhiman@oodlestechnologies.com ankit.uniyal@oodlestechnologies.com

else
echo "TOmcat all good  folks, nothing to do !"
fi
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


