# ----------- Stage 1: Build with Maven -----------
FROM public.ecr.aws/docker/library/maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# ----------- Stage 2: Run with JRE -----------
FROM public.ecr.aws/docker/library/openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/online-banking-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
