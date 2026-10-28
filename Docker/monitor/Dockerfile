FROM python:3.12-slim
WORKDIR /app
COPY app.py .
ENV APP_NAME="ERA Monitor"
ENV INTERVAL=5
CMD ["python", "-u", "app.py"]
