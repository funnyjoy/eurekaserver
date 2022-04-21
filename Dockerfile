FROM adoptopenjdk:11-jdk-hotspot
RUN apt update && apt upgrade -y && apt install -y curl 
RUN adduser --home /home/appuser --shell /bin/sh appuser 
USER appuser 

WORKDIR /home/appuser 
ARG JAR_FILE 
COPY target/${JAR_FILE} app.jar 
ENV PROFILE=local 
ENV SPRING_CLOUD_CONFIG_URI=http://localhost:8888
ENV EUREKA_PORT=8761
ENV OTHER_EUREKA_URI=eurekaserver2:8762

RUN echo "java -Djava.security.egd=file:/dev/./urandom -Dspring.profiles.active=${PROFILE} -jar app.jar" > run.sh

#ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-Dspring.profiles.active=${PROFILE}","-jar","app.jar"]
ENTRYPOINT ["sh", "run.sh"]

