# Use a Python 3.9.6 Alpine base image optimized for Render.com
FROM python:3.9.6-alpine3.14

# Set environment variables for Python
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Set the working directory
WORKDIR /app

# Install system dependencies first (for better caching)
RUN apk add --no-cache \
    gcc \
    libffi-dev \
    musl-dev \
    ffmpeg \
    aria2 \
    make \
    g++ \
    cmake \
    wget \
    unzip

# Install Bento4 for mp4decrypt
RUN wget -q https://github.com/axiomatic-systems/Bento4/archive/v1.6.0-639.zip && \
    unzip v1.6.0-639.zip && \
    cd Bento4-1.6.0-639 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc) && \
    cp mp4decrypt /usr/local/bin/ && \
    cd ../.. && \
    rm -rf Bento4-1.6.0-639 v1.6.0-639.zip

# Copy requirements first for better Docker layer caching
COPY requirements.txt .

# Install Python dependencies
RUN pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir --upgrade -r requirements.txt && \
    python3 -m pip install -U yt-dlp

# Copy the rest of the application
COPY . .

# Create necessary directories
RUN mkdir -p downloads logs && \
    touch dynamic_tokens.json && \
    chmod 666 dynamic_tokens.json

# Set the command to run only the Telegram bot worker
CMD ["python3", "main.py"]
