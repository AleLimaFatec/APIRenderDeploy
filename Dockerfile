# etapa de build usando Maven e OpenJDK 23
FROM maven:3.9.9-openjdk-23 AS build
WORKDIR /app
COPY pom.xml ./
COPY src ./src
RUN mvn clean package -DskipTests

# etapa de runtime com Temurin 23
FROM eclipse-temurin:23-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENV PORT ${PORT}
EXPOSE ${PORT}
ENTRYPOINT ["java", "-jar", "app.jar"]
