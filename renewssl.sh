# a script for auto renew ssl license.


# Renew the lincese :

kill -9 $(ps ax | grep tomcat | fgrep -v grep | awk '{ print $1 }')

# sudo firewall-cmd --permanent --add-port=80/tcp

# sudo firewall-cmd --permanent --add-port=443/tcp

# firewall-cmd --reload

/home/opc/./certbot-auto renew --preferred-challenge http

cp /etc/letsencrypt/live/albert6.com/fullchain.pem /home/opc/apache-tomcat-8.0.39/conf/letsencrypt

cp /etc/letsencrypt/live/albert6.com/privkey.pem  /home/opc/apache-tomcat-8.0.39/conf/letsencrypt


rm -rf /home/opc/apache-tomcat-8.0.39/conf/letsencrypt/fullchain_and_key.p12

openssl pkcs12 -export -in /home/opc/apache-tomcat-8.0.39/conf/letsencrypt/fullchain.pem -inkey /home/opc/apache-tomcat-8.0.39/conf/letsencrypt/privkey.pem -out /home/opc/apache-tomcat-8.0.39/conf/letsencrypt/fullchain_and_key.p12 -name tomcat -password pass:123456


keytool -importkeystore -deststorepass '123456' -destkeypass '123456' -destkeystore /home/opc/apache-tomcat-8.0.39/conf/letsencrypt/MyDSKeyStore.jks -srckeystore /home/opc/apache-tomcat-8.0.39/conf/letsencrypt/fullchain_and_key.p12 -srcstoretype PKCS12 -srcstorepass '123456' -alias tomcat -noprompt


/home/opc/apache-tomcat-8.0.39/bin/./startup.sh

# Logs:

# /home/opc/apache-tomcat-8.0.39/conf/letsencrypt
