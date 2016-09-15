require 'net/http'
require 'nokogiri'
require 'uri'

require_relative 'page'
require_relative 'html_whitespace_cleaner'


page1 = Page.new("https://www.nm.org/help")
p page1.get_rid_of_non_contact_info_ptags
p "***********************"
p page1.get_rid_of_non_contact_info

p "#################"

page2 = Page.new("http://www.trinity-health.org/media-contacts")

p page2.get_rid_of_non_contact_info_ptags
p "***********************"
p page2.get_rid_of_non_contact_info

