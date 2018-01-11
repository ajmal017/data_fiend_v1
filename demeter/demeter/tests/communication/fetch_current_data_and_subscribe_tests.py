# -*- coding: utf-8 -*-
import requests
import json
import jwt
from __future__ import unicode_literals
from django.test import TestCase
from persephone.models import *

class TestFetchCurrentDataAndSubscribe(TestCase):
    def setUp(self):
        payload = { 'username': auth_secrets['USERNAME'],
                'password': auth_secrets['PASSWORD'] }
        web_token = jwt.encode(payload, auth_secrets['HMAC_SECRET'], 'HS256')
        self.headers = { 'X-Token': web_token }

    def test_get_current_data(self):
        response = requests.get(url_secrets['JANUS'] + '/current_subscribe', params={ 'instrument': 'AAPL' }, headers=self.headers)


        self.assertEqual(response.status_code, 200)

        body = json.loads(response.body)
        self.assertEqual(body['message'], 'Subscribed to AAPL')
        sleep(10)

        self.assertEqual(Stock.objects.count(), 1)
        self.assertEqual(Instruments.objects.count(), 1)
        new_price = Stock.objects.first()

        # test has all attributes

        print 'waiting for next entry...'
        sleep(70)
        self.assertEqual(Stock.objects.count(), 2)
       
    def current_data_without_auth:
        pass

    def current_data_with_wrong_password:
        pass

    def current_data_with_wrong_ip:
        pass
