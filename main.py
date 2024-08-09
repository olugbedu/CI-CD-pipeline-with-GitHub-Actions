
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Welcome to Adedeji's Portfolio"}

@app.get("/about")
def read_about():
    return {"about": "This is Adedeji's portfolio application."}











# from fastapi import FastAPI

# app = FastAPI()

# @app.get("/")
# def read_root():
#     return {"message": "Hello, Welcome to KodeCamp DevOps Bookcamp!"}