import requests
import jwt
import json
from __future__ import unicode_literals
from django.test import TestCase

class BuySellTest(TestCase):
    def setUp(self):
        payload = { 'username': auth_secrets['USERNAME'],
                'password': auth_secrets['PASSWORD'] }
        web_token = jwt.encode(payload, auth_secrets['HMAC_SECRET'], 'HS256')
        self.headers = { 'X-Token': web_token }

    def test_buy(self):
        pass
