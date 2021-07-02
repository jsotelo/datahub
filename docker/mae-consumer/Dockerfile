FROM openjdk:8 as builder

COPY . datahub-src
RUN cd datahub-src && ./gradlew :metadata-jobs:mae-consumer-job:build \
    && cp metadata-jobs/mae-consumer-job/build/libs/mae-consumer-job.jar ../mae-consumer-job.jar \
    && cd .. && rm -rf datahub-src

FROM openjdk:8-jre-alpine
ENV DOCKERIZE_VERSION v0.6.1
RUN apk --no-cache add curl tar \
    && curl -L https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz | tar -C /usr/local/bin -xzv

# Install packages; clear cache afterwards
RUN apk add --upgrade --no-cache bash curl openssl ca-certificates e2fsprogs-libs krb5-conf krb5-libs libcom_err musl krb5 && \
    rm -f /var/cache/apk/*

# Install certs
COPY certs/* /usr/local/share/ca-certificates/
RUN update-ca-certificates
RUN keytool -importcert -keystore $JAVA_HOME/lib/security/cacerts -file /usr/local/share/ca-certificates/viasat-ca.crt -storepass changeit -noprompt -alias viasat-ca
RUN keytool -importcert -keystore $JAVA_HOME/lib/security/cacerts -file /usr/local/share/ca-certificates/viasatio.crt -storepass changeit -noprompt -alias viasatio

COPY --from=builder /mae-consumer-job.jar /mae-consumer-job.jar
COPY docker/mae-consumer/start.sh /start.sh
COPY docker/mae-consumer/kinit.sh /kinit.sh
RUN chmod +x /start.sh

EXPOSE 9091

CMD /start.sh