# -*- coding: utf-8 -*-
from __future__ import unicode_literals
import factory
from persephone.models import *

class PriceFactory(factory.Factory):
    class Meta:
        model = models.Price
    date = "2012-03-23 00:00:00"
    symbol = "AIG"
    open = 23.00
    close = 43.00
    low = 30.00
    high = 34.00
    volume = 123.45

class FundementalFactory(factory.Factory):
    class Meta:
        model = models.Fundemental
    symbol = "AIG"
    
    for attribute_name in (dir(Fundemental - dir(models.Model))[2:]:
            setattr(self, attribute_name, uniform(20.00, 2344.00)) 

class SecurityFactory(factory.Factory):
    class Meta:
        model = models.Security
    symbol = "AIG"
    date_added = "2012-03-24"
    cik = 12345

    for attribute_name in (dir(Security) - dir(models.Model))[1:-3:]:
        setattr(self, attribute_name, "JustFoTests")


