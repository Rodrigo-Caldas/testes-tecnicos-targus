FROM python:latest

COPY app app

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

CMD ["python", "app/app.py"]