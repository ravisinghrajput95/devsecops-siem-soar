# Stage 1: build
FROM python:3.11-slim as builder
WORKDIR /app

COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app /app

# Stage 2: runtime
FROM python:3.11-slim

WORKDIR /app
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /app /app

RUN useradd -m nonroot && chown -R nonroot:nonroot /app
USER nonroot

EXPOSE 8080
ENV APP_LOG_PATH=/var/log/app.log

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]
