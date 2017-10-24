# -*- coding: utf-8 -*-
from __future__ import absolute_import
import scrapy
from scrapy.spiders import Rule, CrawlSpider
from scrapy.linkextractors import LinkExtractor
from hnews.items import HnewsItem

class HackerNewsSpider(CrawlSpider):
    name = 'hnews'
    allowed_domains = ['news.ycombinator.com']
    start_urls = ['https://news.ycombinator.com/news?p=1']
    rules = [Rule(LinkExtractor(allow=r'news\?p=[0-9]'), follow=True, callback="parse_news")]

    def parse_news(self, response):
        itemtable = response.css(".itemlist")
        item = HnewsItem()
        for row in itemtable.css("tr"):
            if row.css(".athing") != []:
                item['title'] = row.css(".storylink::text").extract_first()
                item['url'] = row.css(".storylink::attr(href)").extract_first()
            elif row.css(".score") != []:
                item['score'] = int(row.css(".score::text").extract_first().split(' ')[0])
                item['submitter'] = row.css(".hnuser::text").extract_first()
                item['id_'] = int(row.xpath(".//a[3]").xpath('@href').extract_first().split("=")[-1])
                comments = row.xpath(".//a[3]/text()").extract_first()[:-9]
                if comments == "":
                    item['comments'] = 0
                else:
                    item['comments'] = int(comments)
            else:
                if 'title' in item:
                    yield item
                    item = HnewsItem()
