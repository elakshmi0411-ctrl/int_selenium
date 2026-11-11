
# Use Maven with Java 17
FROM maven:3.9.6-eclipse-temurin-17

# Set working directory
WORKDIR /app

# Install Chromium and ChromeDriver
RUN apt-get update && apt-get install -y --no-install-recommends \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*

# Copy Maven configuration
COPY pom.xml .

# Copy Java test source code
COPY src ./src

# Copy HTML login page
COPY webpage ./webpage

# Copy TestNG configuration
COPY testng.xml .

# Set Chromium browser path
ENV CHROME_BIN=/usr/bin/chromium

# Run Selenium TestNG tests
CMD ["mvn", "clean", "test"]
