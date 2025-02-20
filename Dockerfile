# Use a stable Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file first (for caching)
COPY requirements.txt .

# Install required system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Ensure pip is up-to-date and install Python dependencies
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . .

# Expose application port
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]
