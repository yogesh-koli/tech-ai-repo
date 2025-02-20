# Use a stable Python version
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy requirements file first (for caching)
COPY requirements.txt .

# Ensure pip is up-to-date
RUN apt-get update && apt-get install -y gcc libpq-dev \
    && pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app files
COPY . .

# Expose port
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]
