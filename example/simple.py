from locust import HttpLocust
from locust import TaskSet
from locust import task
from locust.web import app

from src import report

# For reporting
app.add_url_rule('/htmlreport', 'htmlreport', report.download_report)

class SimpleBehavior(TaskSet):
    
    @task
    def index(self):
        response = self.client.get("/produce?msg=Hello!")
        print "Response:", response.status_code 

class MyLocust(HttpLocust):
    task_set = SimpleBehavior
    min_wait = 0
    max_wait = 0

"""
Target url: http://ipaas-ecsal-la7z7udmdlgh-748844372.ap-southeast-2.elb.amazonaws.com:8080
Path of load testing script: example/simple.py
Number of slave(s): 5
Run type [automatic/manual]: manual
"""
