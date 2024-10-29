# Etapa de Build
FROM maven:3.8.6-openjdk-11 AS builder 

# Define o diretório de trabalho
WORKDIR /root/app

# Copia os arquivos do projeto para o container
COPY . .

# Adiciona permissão de execução para o script Maven Wrapper
RUN chmod +x mvnw

# Executa o Maven para compilar o projeto sem testes
RUN ./mvnw clean install -DskipTests

# Etapa da Aplicação
FROM openjdk:11-jre-slim AS application

# Define o diretório de trabalho
WORKDIR /home/app

# Copia o JAR gerado na etapa de build
COPY --from=builder /root/app/target/*.jar app.jar

# Expõe a porta usada pela aplicação
EXPOSE 8080

# Define o comando de entrada para iniciar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
