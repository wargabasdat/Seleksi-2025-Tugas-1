# Data Scraping/src/game_scrapers/settings.py

BOT_NAME = "game_scrapers"

SPIDER_MODULES = ["game_scrapers.spiders"]
NEWSPIDER_MODULE = "game_scrapers.spiders"
ITEM_PIPELINES = {
    'game_scrapers.pipelines.JsonWriterPipeline': 300,
}
LOG_LEVEL = 'DEBUG'