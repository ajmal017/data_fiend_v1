import requests
import jwt
import json
from __future__ import unicode_literals
from django.test import TestCase

class FetchHistoricalDataTest(TestCase):
    def setUp(self):
        payload = { 'username': auth_secrets['USERNAME'],
                'password': auth_secrets['PASSWORD'] }
        web_token = jwt.encode(payload, auth_secrets['HMAC_SECRET'], 'HS256')
        self.headers = { 'X-Token': web_token }

    def test_historical_data(self):
        response = requests.get(url_secrets['JANUS'] + '/hist', params={ 'app': 'apollo', 'instrument': 'AAPL', 'start_date': '2012-03-23 00:00:00', 'end_date': '2014-03-23 00:00:00' }, headers=self.headers)

        self.assertEqual(response.status_code, 200)

        body = json.load(response.body)

        self.assertEqual(body['message'], 'added to queue')

    def test_historical_data_invalid_date(self):
        pass

    def test_historical_data_invalid_auth(self):
        pass
