#!/bin/sh

export IDB_KEYTAB_PATH=/keytab

# Update Kerberos config
curl ${KRB5_CONF_URL} -u ${IDB_USERNAME}:${IDB_PASSWORD} > /etc/krb5.conf

# Create keytab file
if [ ! -f ${IDB_KEYTAB_PATH} ]; then
    ./kinit.sh
fi

dockerize \
  -wait tcp://$KAFKA_BOOTSTRAP_SERVER \
  -wait http://$ELASTICSEARCH_HOST:$ELASTICSEARCH_PORT \
  -wait http://$NEO4J_HOST \
  -timeout 240s \
  java -jar mae-consumer-job.jar