# Builder
FROM ghcr.io/openlegacy/graalvm-ce:latest AS builder
COPY . /root/app/
WORKDIR /root/app
RUN ./mvnw clean install -DskipTests

# Application
FROM ghcr.io/openlegacy/graalvm-ce:latest AS application
COPY --from=builder /root/app/target/*.jar /home/app/app.jar
WORKDIR /home/app
RUN chmod +x /home/app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
