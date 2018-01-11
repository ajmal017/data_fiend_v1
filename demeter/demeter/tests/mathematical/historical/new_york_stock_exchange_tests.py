# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.test import TestCase
from persephone.models import *

class NewYorkStockPricesTestCase(TestCase):
    def setUp(self):
        pass
        with open('/data/ny_stock/prices-split-adjusted.csv') as file:
            for row in csv.reader(file):
                Price.objects.get_or_create(
                        date = row[0],
                        symbol = row[1],
                        open = row[2],
                        close = row[3],
                        low = row[4],
                        high = row[5],
                        volume = row[6],
        print 'NY stock exchange price data seeded' 
        with open('/data/ny_stock/fundementals.csv') as file:
            for row in csv.reader(file):
               #fuck my life

        print 'NY stock exchange fundemental data seeded'

    def test_linear_regression_predict_next_on_volume(self):
        pass
        linreg = LinRegBot.new({'obj': 'Price',
            'attribute': 'volume',
            'symbol': ,
            'start_interval': ,
            'end_interval': ,
            'working_interval': ,
            })
        next_volume_reg = linreg.predict_next()
        next_volume_spicy = linreg.predict_next_advanced()

        #assert some shit

    def test_multiple_linear_regression_on_low_and_high(self):
        pass
        linreg1 = LinRegBot.new({'obj': 'Price',
            'attribute': 'high',
            'symbol': ,
            'start_interval': ,
            'end_interval': ,
            'working_interval': ,
            })
        linreg2 = LinRegBot.new({'obj': 'Price',
            'attribute': 'low',
            'symbol': ,
            'start_interval': ,
            'end_interval': ,
            'working_interval': ,
            })
        val_1 = linreg1.multiple_regression_value(linreg2)
        val_2 = linreg2.multiple_regression_value(linreg1)
        val_3 = linreg1.advanced_multiple_regression_value(linreg2)
        val_4 = linreg2.advanced_multiple_regression_value(linreg1)
        val_5 = linreg1.similar?(linreg2)
        val_6 = linreg2.similar?(linreg1)
        val_7 = linreg1.better?(linreg2)
        val_8 = linreg2.better?(linreg1)
        val_8 = linreg1.worse?(linreg2)
        val_9 = linreg2.worse?(linreg1)

        #assert some more shit
        #self.assertEqual(lion.speak(), 'The lion says "roar"')
