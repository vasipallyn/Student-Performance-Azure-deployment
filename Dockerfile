#FROM python:3.10-slim
#WORKDIR /app
#COPY . /app

#RUN apt-get update -y && apt-get install -y awscli 

#RUN pip install --upgrade pip setuptools wheel && \
 #   pip install -r requirements.txt
#CMD ["python3", "app.py"]
# Use a lightweight Python base image

FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies efficiently
RUN apt-get update && apt-get install -y --no-install-recommends \
    awscli \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install Python dependencies without caching
COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . /app

# Run the app
CMD ["python3", "app.py"]
