import requests
import jwt
from __future__ import unicode_literals
from django.test import TestCase

class CommunicationTest(TestCase):
    def setUp(self):
        payload = { 'username': auth_secrets['USERNAME'],
                'password': auth_secrets['PASSWORD'] }
        web_token = jwt.encode(payload, auth_secrets['HMAC_SECRET'], 'HS256')
        self.headers = { 'X-Token': web_token }

    def test_janus(self):
        response = requests.get(url_secrets['JANUS'] + '/test', params={ 'app': 'janus' }, headers=self.headers)

        self.assertEqual(response.status_code, 200)
        
        body = json.load(response.body)

        self.assertEqual(body['message'], 'Janus operational')

    def test_apollo(self):
        response = requests.get(url_secrets['JANUS'] + '/test', params={'app': 'apollo'}, headers=self.headers)

        self.assertEqual(response.status_code, 200)

        body = json.load(response.body)

        self.assertEqual(body['message'], 'Apollo operational')
