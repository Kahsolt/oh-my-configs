import scrapy
import os

class QuotesSpider(scrapy.Spider):
    name = 'quotes'
    allowed_domains = ['quotes.toscrape.com']
    start_urls = [
        'http://quotes.toscrape.com/page/1/',
    ]

    extract_one = lambda sel, css: sel.css(css).extract_first().strip()
    extract_all = lambda sel, css: [ex.strip() for ex in  sel.css(css).extract()]

    def parse(self, response):
        for quote in response.css('div.quote'):
            yield {
                'text': extract_one('span.text::text'),
                'author': extract_one('small.author::text'),
                'tags': extract_all('div.tags a.tag::text'),
            }

        for a in response.css('li.next a'):
            yield response.follow(a, callback=self.parse)
