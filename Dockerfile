####
# This Dockerfile is used in order to build a container that runs the Quarkus application in native (no JVM) mode
####

### Image for getting maven dependencies and then acting as a cache for the next image
FROM maven:3.6.3-jdk-11 as mavencache
ENV MAVEN_OPTS=-Dmaven.repo.local=/mvnrepo
COPY pom.xml /app/
WORKDIR /app
RUN mvn test-compile dependency:resolve dependency:resolve-plugins

### Image for building the native binary
FROM oracle/graalvm-ce:19.3.1-java11 AS native-image
ENV MAVEN_OPTS=-Dmaven.repo.local=/mvnrepo
COPY --from=mavencache /mvnrepo/ /mvnrepo/
COPY . /app
WORKDIR /app
ENV GRAALVM_HOME=/usr
RUN gu install native-image && \
    ./mvnw package -Pnative -Dmaven.test.skip=true && \
    # Prepare everything for final image
    mkdir -p /dist && \
    cp /app/target/*-runner /dist/application

### Final image based on scratch containing only the binary
FROM scratch
COPY --chown=1000 --from=native-image /dist /work
EXPOSE 8080
USER 1000
WORKDIR /work/
CMD ["./application", "-Djava.io.tmpdir=/work/tmp"]
