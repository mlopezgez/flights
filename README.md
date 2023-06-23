# Flights

## Introduction

This repository provides an ML solution to calculate the probability of delays in arrival or departure for flights that depart from Santiago de Chile.

It uses Scikit-Learn as the main library for creating the model, Fast-API to serve, and Mangum to create an AWS lambda function with the code.

It also uses terraform to define the infrastructure needed.

<img src="./assets/infrastructure.png">

This infrastructure uses an API Gateway as an entry point, a serverless solution ensuring scalability.

Then, a Lambda Function is responsible for loading the model and running inference.

The Lambda uses a Docker image with the code, and we store this image in ECR.

A CI/CD process is implemented with GitHub Actions, which builds the image and pushes it to ECR.

## The Data

I fetched data from [Aviation Stack](https://aviationstack.com/). This API haves historical data on previous flights.

I built a dataset of 1,000 samples for flights that depart from SCL.

The data is stored as a Parquet file in the folder data of this repository.

The columns of interest for my experiments were:

```
[
    'flight_number',
    'airline_iata',
    'iata_departure',
    'scheduled_departure',
    'actual_departure',
    'iata_arrival',
    'scheduled_arrival',
    'actual_arrival',
    'delay_departure',
    'delay_arrival',
    'flight_day',
    'flight_month',
    'flight_year',
    'delayed_departure',
    'delayed_arrival'
]
```

Here, I assumed the flight would be delayed if the delay was greater than 25 minutes. This assumption applies to arrivals and departures.

## The Model

I tested two machine-learning models:
- SVC.
- Logistic Regression.

The best results for each problem (arrivals and departures) were:
- Logistic Regression for Departures
- SVC for Arrivals

The models are defined in the following way:

There are two preprocessing steps:

- One Hot Encoding (For categorical variables)
- Standar Scaler (For numerical variables)

### Departures Model

The model for departures is as follows:

<p align="center">
    <img src="./assets/departures.png" width="250">
</p>

Metrics obtained:

```bash
Accuracy: 0.833333
Precision: 0.833333
Recall: 0.365854
F1: 0.508475
```

### Arrivals Model

The model for arrivals is as follows:

<p align="center">
    <img src="./assets/arrivals.png" width="250">
</p>

Metrics obtained:

```bash
Accuracy: 0.816092
Precision: 0.819767
Recall: 0.992958
F1: 0.898089
```