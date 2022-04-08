FROM python:3.8.13-slim-buster

WORKDIR /app
COPY init_oidc.py requirements.txt ./

RUN pip install --no-cache-dir --upgrade pip -r requirements.txt

CMD ["python", "/app/init_oidc.py"]