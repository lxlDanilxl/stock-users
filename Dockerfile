FROM maven:3.9.6-eclipse-temurin-21 AS build

# Package the application
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn package -DskipTests

#Execute the application
FROM eclipse-temurin:21.0.1_12-jre
WORKDIR /app
COPY --from=build /app/target/warehouse-api-1.0.0.jar .
EXPOSE 8080
CMD ["java", "-jar", "warehouse-api-1.0.0.jar"]