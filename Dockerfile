FROM python:3.9

# Create working directory
WORKDIR /app/backend

# Copy dependency list
COPY requirements.txt /app/backend/

# Install system packages required for mysqlclient
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy the full project
COPY . /app/backend

# Expose port for Django
EXPOSE 8000

# Run Django server
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
