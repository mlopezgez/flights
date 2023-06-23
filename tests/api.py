from locust import HttpUser, task

DATA = {
    "airline_iata": "AV",
    "iata_arrival": "BOG",
    "flight_day": 21,
    "flight_month": 6,
    "flight_year": 2023
}


class WebsiteUser(HttpUser):

    @task
    def arrivals(self):
        self.client.post(url="/arrivals", json=DATA)

    @task
    def departures(self):
        self.client.post(url="/departures", json=DATA)
