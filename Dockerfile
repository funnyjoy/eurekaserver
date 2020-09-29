FROM adoptopenjdk/openjdk8:x86_64-alpine-jre8u222-b10 
RUN apk --no-cache add curl 
RUN adduser -D -s /bin/sh appuser 
USER appuser 

WORKDIR /home/appuser 
ARG JAR_FILE 
COPY target/${JAR_FILE} app.jar 
ENV PROFILE=local 
ENV SPRING_CLOUD_CONFIG_URI=http://localhost:8888
ENV EUREKA_PORT=8761
ENV OTHER_EUREKA_URI=eurekaserver2:8762
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-Dspring.profiles.active=${PROFILE}","-jar","app.jar"]
