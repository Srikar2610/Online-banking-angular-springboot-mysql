# Use Maven with OpenJDK 17 from Amazon ECR Public
FROM public.ecr.aws/docker/library/maven:3.8.5-openjdk-17 AS builder

WORKDIR /app

COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Use OpenJDK runtime image from Amazon ECR Public
FROM public.ecr.aws/docker/library/openjdk:17-slim

WORKDIR /app
COPY --from=builder /app/target/online-banking-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
