FROM maven:3.6-jdk-11 as builder
RUN git clone https://github.com/mpassid/shibboleth-idp-monitor
RUN cd shibboleth-idp-monitor && mvn clean verify

FROM openjdk:11
RUN mkdir -p /opt/mpass-monitor-standalone
COPY --from=builder shibboleth-idp-monitor/idp-mpass-monitor-standalone/target/idp-mpass-monitor-standalone-0.9.5-SNAPSHOT.jar /opt/mpass-monitor-standalone/idp-mpass-monitor-standalone.jar
CMD ["java","-jar","/opt/mpass-monitor-standalone/idp-mpass-monitor-standalone.jar","--flowsDirectory=/opt/mpass-monitor-flows"]
EXPOSE 8080
