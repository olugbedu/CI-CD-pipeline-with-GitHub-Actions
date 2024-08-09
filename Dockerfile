# Use the official Python image from the Docker Hub
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir fastapi uvicorn

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]













# Use the official Python image
# FROM python:3.12-slim

# # Set the working directory
# WORKDIR /app

# # Copy current directory contents into the container
# COPY . /app

# # Install dependencies
# RUN pip install -r requirements.txt

# # Make port 8000 available outside the container
# EXPOSE 8000

# # Run the app
# CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
