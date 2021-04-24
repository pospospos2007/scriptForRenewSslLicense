# scriptForRenewSslLicense
a script for auto renew ssl license.


Renew the lincese :

sudo kill -9 $(ps ax | grep tomcat | fgrep -v grep | awk '{ print $1 }')

sudo ./certbot-auto renew --preferred-challenge http

sudo cp /etc/letsencrypt/live/albert6.com/fullchain.pem ~/apache-tomcat-8.0.39/conf/letsencrypt

sudo cp /etc/letsencrypt/live/albert6.com/privkey.pem  ~/apache-tomcat-8.0.39/conf/letsencrypt

cd ~/apache-tomcat-8.0.39/conf/letsencrypt

rm -rf fullchain_and_key.p12

sudo openssl pkcs12 -export -in fullchain.pem -inkey privkey.pem -out fullchain_and_key.p12 -name tomcat

#-passout pass:

123456

123456

sudo keytool -importkeystore -deststorepass '123456' -destkeypass '123456' -destkeystore MyDSKeyStore.jks -srckeystore fullchain_and_key.p12 -srcstoretype PKCS12 -srcstorepass '123456' -alias tomcat

yes

Logs:

/home/opc/apache-tomcat-8.0.39/conf/letsencrypt
