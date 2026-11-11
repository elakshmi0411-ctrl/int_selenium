
FROM maven:3.9.6-eclipse-temurin-17

WORKDIR /app

# Install dependencies required for Google Chrome
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://dl.google.com/linux/linux_signing_key.pub \
       | gpg --dearmor --yes -o /etc/apt/keyrings/google-chrome.gpg \
    && echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main" \
       > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Copy Maven configuration
COPY pom.xml .

# Copy Java source files
COPY src ./src

# Copy login webpage
COPY webpage ./webpage

# Chrome executable location
ENV CHROME_BIN=/usr/bin/google-chrome

# Run Selenium tests when container starts
CMD ["mvn", "test"]
