"""Arquivo principal."""

from fastapi import FastAPI
from fastapi import status
import uvicorn


app = FastAPI(debug=True)


@app.get("/", status_code=status.HTTP_200_OK)
def home():
    """Endpoint exemplo."""
    return "Olá!"


if __name__ == "__main__":
    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=8888,
        log_level="info",
        reload=True,
        debug=True,
    )
