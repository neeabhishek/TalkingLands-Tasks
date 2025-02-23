#Using the base image as python:3.8-slim (lightweight).
FROM python:3.8-slim 
WORKDIR /app 
COPY . /app
#Exposing/Mapping the port of the web application when running the container.
EXPOSE 5000
#Installing Flash and Werkzeug module using pip3
RUN pip3 install -r requirements.txt
CMD ["python3","app.py"]