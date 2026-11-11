
FROM maven:3.9.6-eclipse-temurin-17

WORKDIR /app

# Install Chromium and ChromeDriver
RUN apt-get update && apt-get install -y --no-install-recommends \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY pom.xml .
COPY src ./src
COPY webpage ./webpage
COPY testng.xml .

# Configure browser path
ENV CHROME_BIN=/usr/bin/chromium

# Execute Selenium tests
CMD ["mvn", "test"]
