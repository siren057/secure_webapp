FROM python:3.11-slim AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.11-slim

RUN addgroup --system appgroup && adduser --system --group appuser

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.11/site-packages/ /usr/local/lib/python3.11/site-packages/

COPY --chown=appuser:appgroup app.py .

USER appuser

EXPOSE 5000

CMD ["python", "app.py"]
