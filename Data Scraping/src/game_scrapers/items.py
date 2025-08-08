# Data Scraping/src/game_scrapers/items.py
import scrapy


# ===================================================================
# 1. ITEMS GENERIC (Bisa dipakai oleh banyak spider)
# ===================================================================

class ChangeHistoryItem(scrapy.Item):
    """Mendefinisikan data untuk satu entri riwayat perubahan (Change History)."""
    version = scrapy.Field()
    change = scrapy.Field()

class EquipmentAbilityItem(scrapy.Item):
    """Mendefinisikan data untuk satu ability dari equipment (Sword/Gun)."""
    equipment_name = scrapy.Field()
    keybind = scrapy.Field()
    ability_name = scrapy.Field()
    mastery_cost = scrapy.Field()

# ===================================================================
# 2. ITEMS SPESIFIK UNTUK FRUIT
# ===================================================================

class AbilityItem(scrapy.Item):
    """Mendefinisikan data untuk satu ability dari Blox Fruit."""
    fruit_name = scrapy.Field()
    fragment_cost = scrapy.Field()
    keybind = scrapy.Field()
    ability_name = scrapy.Field()
    cooldown = scrapy.Field()
    energy = scrapy.Field()
    breaks_instinct = scrapy.Field()
    instinct_notes = scrapy.Field()
    instinct_trickable = scrapy.Field()
    mastery_cost = scrapy.Field()

class FruitDetailsItem(scrapy.Item):
    """Mendefinisikan data lengkap untuk satu Blox Fruit."""
    uid = scrapy.Field()
    fruit_name = scrapy.Field()
    url = scrapy.Field()
    timestamp = scrapy.Field()
    type = scrapy.Field()
    rarity = scrapy.Field()
    money_price = scrapy.Field()
    robux_price = scrapy.Field()
    awakening_cost = scrapy.Field()
    can_m1 = scrapy.Field()
    release_date = scrapy.Field()
    abilities = scrapy.Field()  # List berisi objek AbilityItem
    change_history = scrapy.Field()  # List berisi objek ChangeHistoryItem

class FruitStockItem(scrapy.Item):
    """Mendefinisikan SATU buah yang ada di dalam sebuah stock event."""
    stock_event_uid = scrapy.Field()
    fruit_name = scrapy.Field()
    price = scrapy.Field()

class FruitStockResultItem(scrapy.Item):
    """Mendefinisikan SATU kejadian stock (stock event)."""
    stock_event_uid = scrapy.Field()
    timestamp = scrapy.Field()
    stock_start_time = scrapy.Field()


class FruitValuesItem(scrapy.Item):
    fruit_name = scrapy.Field()
    value = scrapy.Field()
    demand = scrapy.Field()
    status = scrapy.Field()

# ===================================================================
# 3. ITEMS SPESIFIK UNTUK EQUIPMENT (SWORD & GUN)
# ===================================================================

class BaseEquipmentItem(scrapy.Item):
    """
    Kelas dasar yang menampung field umum untuk semua equipment.
    Ini digunakan untuk menghindari duplikasi kode (Prinsip DRY).
    """
    uid = scrapy.Field()
    url = scrapy.Field()
    timestamp = scrapy.Field()
    type = scrapy.Field()
    rarity = scrapy.Field()
    release_date = scrapy.Field()
    abilities = scrapy.Field()  # List berisi objek EquipmentAbilityItem
    change_history = scrapy.Field()  # List berisi objek ChangeHistoryItem

class SwordDetailsItem(BaseEquipmentItem):
    """
    Mendefinisikan data untuk Sword.
    Mewarisi field umum dari BaseEquipmentItem.
    """
    sword_name = scrapy.Field()

class GunDetailsItem(BaseEquipmentItem):
    """
    Mendefinisikan data untuk Gun.
    Mewarisi field umum dari BaseEquipmentItem.
    """
    gun_name = scrapy.Field()


