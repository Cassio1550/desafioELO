# Builder
FROM springci/graalvm-ce:latest AS builder
COPY  . /root/app/
WORKDIR /root/app
RUN ./mvnw clean install -DskipTests

# Application
FROM springci/graalvm-ce:latest AS application
COPY --from=builder /root/app/target/*.jar /home/app/
WORKDIR /home/app
RUN chmod 0777 /home/app
EXPOSE 8080
ENTRYPOINT java -jar $JAVA_OPTIONS *.jar 
