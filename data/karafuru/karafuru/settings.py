# -*- coding: utf-8 -*-

# Scrapy settings for karafuru project
#
# For simplicity, this file contains only settings considered important or
# commonly used. You can find more settings consulting the documentation:
#
#     https://doc.scrapy.org/en/latest/topics/settings.html
#     https://doc.scrapy.org/en/latest/topics/downloader-middleware.html
#     https://doc.scrapy.org/en/latest/topics/spider-middleware.html

import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

BOT_NAME = 'karafuru'

SPIDER_MODULES = ['karafuru.spiders']
NEWSPIDER_MODULE = 'karafuru.spiders'


# Crawl responsibly by identifying yourself (and your website) on the user-agent
#USER_AGENT = 'karafuru (+http://www.yourdomain.com)'

# Obey robots.txt rules
ROBOTSTXT_OBEY = False

# Configure maximum concurrent requests performed by Scrapy (default: 16)
CONCURRENT_REQUESTS = 8

# Configure a delay for requests for the same website (default: 0)
# See https://doc.scrapy.org/en/latest/topics/settings.html#download-delay
# See also autothrottle settings and docs
DOWNLOAD_DELAY = 0.25
# The download delay setting will honor only one of:
CONCURRENT_REQUESTS_PER_DOMAIN = 8
CONCURRENT_REQUESTS_PER_IP = 8

# Disable cookies (enabled by default)
#COOKIES_ENABLED = True

# Disable Telnet Console (enabled by default)
#TELNETCONSOLE_ENABLED = True

# Override the default request headers:
#DEFAULT_REQUEST_HEADERS = {
#   'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
#   'Accept-Language': 'en',
#}

# Enable or disable spider middlewares
# See https://doc.scrapy.org/en/latest/topics/spider-middleware.html
SPIDER_MIDDLEWARES = {
    'karafuru.middlewares.KarafuruSpiderMiddleware': 543,
    'scrapy_crawl_once.CrawlOnceMiddleware': 100,
}

# Enable or disable downloader middlewares
# See https://doc.scrapy.org/en/latest/topics/downloader-middleware.html
DOWNLOADER_MIDDLEWARES = {
    'scrapy.contrib.downloadermiddleware.useragent.UserAgentMiddleware': None,
    'random_useragent.RandomUserAgentMiddleware': 400,
    'scrapy_crawl_once.CrawlOnceMiddleware': 50,
    'rotating_proxies.middlewares.RotatingProxyMiddleware': 610,
    'rotating_proxies.middlewares.BanDetectionMiddleware': 620,
    'karafuru.middlewares.KarafuruDownloaderMiddleware': 543,
}

# Enable or disable extensions
# See https://doc.scrapy.org/en/latest/topics/extensions.html
EXTENSIONS = {
     'karafuru.extensions.SpiderOpenCloseLogging': 233,
}

# Configure item pipelines
# See https://doc.scrapy.org/en/latest/topics/item-pipeline.html
ITEM_PIPELINES = {
	'scrapy.pipelines.images.ImagesPipeline': 1,
	'scrapy.pipelines.files.FilesPipeline': 1,
	'scrapy_mongodb.MongoDBPipeline': 200,
    'karafuru.pipelines.KarafuruPipeline': 300,
}

# Enable and configure the AutoThrottle extension (disabled by default)
# See https://doc.scrapy.org/en/latest/topics/autothrottle.html
AUTOTHROTTLE_ENABLED = True
# The initial download delay
AUTOTHROTTLE_START_DELAY = 3
# The maximum download delay to be set in case of high latencies
AUTOTHROTTLE_MAX_DELAY = 30
# The average number of requests Scrapy should be sending in parallel to
# each remote server
AUTOTHROTTLE_TARGET_CONCURRENCY = 1.0
# Enable showing throttling stats for every response received:
AUTOTHROTTLE_DEBUG = False

# Enable and configure HTTP caching (disabled by default)
# See https://doc.scrapy.org/en/latest/topics/downloader-middleware.html#httpcache-middleware-settings
HTTPCACHE_ENABLED = True
HTTPCACHE_EXPIRATION_SECS = 0
HTTPCACHE_DIR = 'httpcache'
HTTPCACHE_IGNORE_HTTP_CODES = []
HTTPCACHE_STORAGE = 'scrapy.extensions.httpcache.FilesystemCacheStorage'

# Media Pipelines
MEDIA_ALLOW_REDIRECTS = True
FILES_STORE = os.path.join(BASE_DIR, 'data', 'files')
FILES_EXPIRES = 90
IMAGES_STORE = os.path.join(BASE_DIR, 'data', 'images')
IMAGES_EXPIRES = 30
IMAGES_MIN_HEIGHT = 75
IMAGES_MIN_WIDTH = 75
IMAGES_THUMBS = {
    'small': (50, 50),
    'big': (270, 270),
}

# MongoDB
MONGODB_URI = 'mongodb://localhost:27017'
MONGODB_DATABASE = 'scrapy'
MONGODB_COLLECTION = 'my_items'

# SQLite3
SQLITE_URI = ''

# Proxy
ROTATING_PROXY_LIST_PATH = 'proxies.txt'
