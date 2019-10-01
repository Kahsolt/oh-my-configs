# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html


class KarafuruPipeline(object):
    def process_item(self, item, spider):
        print('item=%r spider=%r' % (item, spider))
        return item


class MongoPipeline(object):

    collection_name = 'scrapy_items'

    def __init__(self, mongo_uri, mongo_db):
        self.mongo_uri = mongo_uri
        self.mongo_db = mongo_db

    @classmethod
    def from_crawler(cls, crawler):
        return cls(
            mongo_uri=crawler.settings.get('MONGO_URI'),
            mongo_db=crawler.settings.get('MONGO_DATABASE', 'items')
        )

    def open_spider(self, spider):
        self.client = pymongo.MongoClient(self.mongo_uri)
        self.db = self.client[self.mongo_db]

    def close_spider(self, spider):
        self.client.close()

    def process_item(self, item, spider):
        self.db[self.collection_name].insert_one(dict(item))
        return item


class DuplicatesPipeline(object):

    def __init__(self):
        self.ids_seen = set()

    def process_item(self, item, spider):
        if item['id'] in self.ids_seen:
            raise DropItem("Duplicate item found: %s" % item)
        else:
            self.ids_seen.add(item['id'])
            return item

from scrapy.exceptions import DropItem
from myproject.items import Product
import dblite

class StoreItemsPipeline(object):
    def __init__(self):
        self.ds = None

    def open_spider(self, spider):
        self.ds = dblite.open(Product, 'sqlite://db/products.sqlite:items', autocommit=True)

    def close_spider(self, spider):
        self.ds.close()

    def process_item(self, item, spider):
        if isinstance(item, Product):
            try:
                self.ds.put(item)
            except dblite.DuplicateItem:
                raise DropItem("Duplicate item found: %s" % item)
        else:
            raise DropItem("Unknown item type, %s" % type(item))
        return item
