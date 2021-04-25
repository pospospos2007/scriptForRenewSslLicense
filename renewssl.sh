
# a script for auto renew ssl license.


# Renew the lincese :

sudo kill -9 $(ps ax | grep tomcat | fgrep -v grep | awk '{ print $1 }')

sudo firewall-cmd --permanent --add-port=80/tcp

sudo firewall-cmd --permanent --add-port=443/tcp

firewall-cmd --reload

sudo ~/./certbot-auto renew --preferred-challenge http

sudo cp /etc/letsencrypt/live/albert6.com/fullchain.pem ~/apache-tomcat-8.0.39/conf/letsencrypt

sudo cp /etc/letsencrypt/live/albert6.com/privkey.pem  ~/apache-tomcat-8.0.39/conf/letsencrypt


rm -rf ~/apache-tomcat-8.0.39/conf/letsencrypt/fullchain_and_key.p12

sudo openssl pkcs12 -export -in ~/apache-tomcat-8.0.39/conf/letsencrypt/fullchain.pem -inkey ~/apache-tomcat-8.0.39/conf/letsencrypt/privkey.pem -out ~/apache-tomcat-8.0.39/conf/letsencrypt/fullchain_and_key.p12 -name tomcat -password pass:123456


sudo keytool -importkeystore -deststorepass '123456' -destkeypass '123456' -destkeystore ~/apache-tomcat-8.0.39/conf/letsencrypt/MyDSKeyStore.jks -srckeystore ~/apache-tomcat-8.0.39/conf/letsencrypt/fullchain_and_key.p12 -srcstoretype PKCS12 -srcstorepass '123456' -alias tomcat -noprompt


sudo ~/apache-tomcat-8.0.39/bin/./startup.sh 

# Logs:

# /home/opc/apache-tomcat-8.0.39/conf/letsencrypt
