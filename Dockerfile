# Etapa de Builder
FROM maven:3.8.6-openjdk-11 AS builder 
WORKDIR /root/app
COPY . .

# Compilação e empacotamento do projeto
RUN mvn clean install -DskipTests

# Etapa de Application
FROM openjdk:11-jre-slim AS application
COPY --from=builder /root/app/target/*.jar /home/app/app.jar
WORKDIR /home/app
EXPOSE 8080

# Comando para rodar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
