FROM maven:3.9.5-eclipse-temurin-21-alpine

COPY pom.xml /app/pom.xml

WORKDIR /app

# Download the dependencies
RUN mvn -B package -Ddir=/tmp/codecrafters-build-http-server-java

# Cache Dependencies
RUN mkdir -p /app-cached
RUN mv /app/target /app-cached # Is this needed?

# Pre-compile steps
# Note: Previously, /tmp/codecrafters-http-target was hardcoded in your_server.sh. We've now switched to using /tmp/codecrafters-build-http-server-java
RUN printf "cd \${CODECRAFTERS_REPOSITORY_DIR} && mvn -B package -Ddir=/tmp/codecrafters-build-http-server-java && sed -i 's/^\(mvn .*\)/#\1/' ./your_server.sh && sed -i 's|/tmp/codecrafters-http-target|/tmp/codecrafters-build-http-server-java|g' ./your_server.sh" > /codecrafters-precompile.sh
RUN chmod +x /codecrafters-precompile.sh