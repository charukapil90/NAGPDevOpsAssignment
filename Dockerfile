FROM tomcat:8.0-alpine
MAINTAINER Charu Kapil
RUN apk update
RUN apk add wget
RUN wget --user=admin --password=password -O /usr/local/tomcat/webapps/demosampleapplication.war http://192.168.1.17:8082/artifactory/nagpAssignment/com/nagarro/devops-tools/devops/demosampleapplication/1.0.0-SNAPSHOT/demosampleapplication-1.0.0-SNAPSHOT.war
EXPOSE 7000
CMD usr/local/tomcat/bin/Catalina.sh run
