# Etapa de build
FROM maven:3.9.9-openjdk-23 AS build
WORKDIR /app
COPY pom.xml ./
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa de runtime
FROM eclipse-temurin:23-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENV PORT ${PORT}
EXPOSE ${PORT}
ENTRYPOINT ["java","-jar","app.jar"]