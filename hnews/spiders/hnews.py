# -*- coding: utf-8 -*-
from __future__ import absolute_import
import scrapy
from scrapy.spiders import Rule, CrawlSpider
from scrapy.linkextractors import LinkExtractor
from hnews.items import HnewsItem, HnewsComment

class HackerNewsSpider(CrawlSpider):
    name = 'hnews'
    allowed_domains = ['news.ycombinator.com']
    start_urls = ['https://news.ycombinator.com/news?p=1']
    rules = [Rule(LinkExtractor(allow=r'news\?p=[0-9]'), follow=True, callback="parse_news"),
             Rule(LinkExtractor(allow=r'item\?id=[0=9]*'), follow=False, callback="parse_comments")]

    def parse_comments(self, response):
        comment_tree = response.css(".comment-tree").xpath("tr[@id]")
        for row in comment_tree:
            item = HnewsComment()
            item['id_'] = row.xpath('@id').extract_first()
            item['username'] = row.css(".hnuser::text").extract_first()
            item['text'] = "\n\n".join(row.css(".comment").xpath(".//*/text()").extract()[:-6])
            item['indent'] = int(row.css(".ind").xpath("./img/@width").extract_first())/40
            yield item

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
