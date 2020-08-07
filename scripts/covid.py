#!/bin/env python

from datetime import datetime
import requests
import json

ITA_EP =  "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-andamento-nazionale-latest.json"

ITA_EP_TIMELINE = "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-andamento-nazionale.json"

def is_going_better(new_data, old_data):
    if ((new_data - old_data) > 0):
        return '+'
    return '' # the dataset contains the negative value

def status_element(js):

    data = json.loads(js)

    tp = data[-1]["totale_positivi"]
    tpo = data[-2]["totale_positivi"]
    tpv = data[-1]["variazione_totale_positivi"]
    d = data[-1]["deceduti"]
    do = data[-2]["deceduti"]
    dv = data[-1]["deceduti"] - data[-2]["deceduti"]

    dg = data[-1]["dimessi_guariti"]
    dgo = data[-2]["dimessi_guariti"]
    dgv = data[-1]["dimessi_guariti"] - data[-2]["dimessi_guariti"]



    s = ' A: {} ({}{}) | D: {} ({}{}) | T: {} ({}{})'.format(tp, is_going_better(tp, tpo),\
            tpv, d, is_going_better(d, do), dv, dg, is_going_better(dg, dgo), dgv)
    print(s)

def get_data():
    response = requests.get(ITA_EP_TIMELINE)
    status_element(response.text)

#def check_data():
#    current_dt = datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
#    #print(current_dt)

get_data()
