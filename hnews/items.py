# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class HnewsItem(scrapy.Item):
    title = scrapy.Field()
    url = scrapy.Field()
    score = scrapy.Field()
    submitter = scrapy.Field()
    id_ = scrapy.Field()
    comments = scrapy.Field()
    
class HnewsComment(scrapy.Item):
	id_ = scrapy.Field()
	username = scrapy.Field()
	text = scrapy.Field()
	indent = scrapy.Field()
	
