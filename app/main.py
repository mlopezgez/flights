import pandas as pd
from joblib import load
from mangum import Mangum
from fastapi import FastAPI
from pydantic import BaseModel


class Body(BaseModel):
    airline_iata: str
    iata_arrival: str
    flight_day: int
    flight_month: int
    flight_year: int


app = FastAPI()


def run_prediction(body, endpoint):
    if endpoint == "arrival":
        model = load("./models/arrival.joblib")
    elif endpoint == "departure":
        model = load("./models/departure.joblib")
    else:
        return {"error": "Invalid endpoint"}

    X = pd.DataFrame([body.dict()])
    prob = model.predict_proba(X)[0][1]
    prediction = 1 if prob > 0.5 else 0

    response = {
        "probability": prob,
        "prediction": prediction,
    }

    return response


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.post("/arrivals")
async def arrivals(body: Body):
    return run_prediction(body, "arrival")

@app.post("/departures")
async def departures(body: Body):
    return run_prediction(body, "departure")



handler = Mangum(app)
