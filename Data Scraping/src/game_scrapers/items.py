# Data Scraping/src/game_scrapers/items.py
import scrapy

class FruitStockItem(scrapy.Item):
    name = scrapy.Field()
    price = scrapy.Field()

class FruitStockResultItem(scrapy.Item):
    timestamp = scrapy.Field()
    stock_start_time = scrapy.Field()
    current_stock = scrapy.Field()  # List of FruitStockItem

class FruitDetailsItem(scrapy.Item):
    fruit_name = scrapy.Field()
    key_bind = scrapy.Field()
    ability_name = scrapy.Field()
    mastery = scrapy.Field()
    description = scrapy.Field()

class FruitValuesItem(scrapy.Item):
    category = scrapy.Field()
    fruit_name = scrapy.Field()
    value = scrapy.Field()
    demand = scrapy.Field()
    status = scrapy.Field()

class BloxFruitsMasterListItem(scrapy.Item):
    fruit_name = scrapy.Field()
    beli_price = scrapy.Field()
    robux_price = scrapy.Field()
    type = scrapy.Field()
    rarity = scrapy.Field()
    can_m1 = scrapy.Field()
    release_date = scrapy.Field()