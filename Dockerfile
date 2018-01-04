FROM openjdk:8-jre
MAINTAINER Benny Zhou <benny_zhou2005@hotmail.com>

# Here add a VOLUME pointing to "/tmp" because that's where a Spring Boot Application creates working directories for Tomcat by default.
# The effect is to create a temporary file on your host under "/var/lib/docker" and link it to the container under "/tmp". 
# This step is optional for the simple application wrote here, but can be necessary for other Spring Boot applications if they need to actually wirte in the filesystem.
VOLUME /tmp

ARG JAR_FILE
# Add project jar file to the container as app.jar, then executed in the ENTRYPOINT
ADD ${JAR_FILE} app.jar

# To reduce Tomcat startup time here add a system property pointing to "/dev/urandom" as a source of entropy.
ENTRYPOINT ["/usr/bin/java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar"]