# Builder
FROM maven:3.8.6-openjdk-11 AS builder  # Usando uma imagem Maven com OpenJDK
COPY . /root/app/
WORKDIR /root/app

# Adicionando permissão de execução para mvnw
RUN chmod +x mvnw

# Executa o Maven para compilar o projeto
RUN ./mvnw clean install -DskipTests

# Application
FROM openlegacy/graalvm-ce:latest AS application
COPY --from=builder /root/app/target/*.jar /home/app/app.jar  # Copia o JAR gerado
WORKDIR /home/app
RUN chmod +x /home/app/app.jar  # Garante que o JAR seja executável
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]  # Executa a aplicação Java
