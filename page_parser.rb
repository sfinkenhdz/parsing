require 'uri'
require 'nokogiri'

require_relative 'html_whitespace_cleaner'


module PageParser

  def self.convert(url)
    uri = URI.parse(url)
    page = Net::HTTP.get(uri)
    clean_html = HTMLWhitespaceCleaner.clean(page)
    @noko_doc = Nokogiri.parse(clean_html)
  end

  def self.create_body
    @noko_doc.css('body').to_s
  end

  def self.create_list_items
    @noko_doc.css("ul li").map { |label| label.text}
  end

  def self.create_p_tags
    @noko_doc.css("p").map { |tag| tag.text}
  end

end




#   def self.clean(html_string)
#     remove_all_white_space_between_tags(fix_the_damn_brs(condense_whitespace(html_string))).strip
#   end

#   private
#   WHITE_SPACE_BETWEEN_TAGS = /(?<=>)\s+(?=<)/

#   def self.remove_all_white_space_between_tags(html_string)
#     html_string.gsub(WHITE_SPACE_BETWEEN_TAGS, "")
#   end

#   def self.condense_whitespace(html_string)
#     html_string.gsub(/\s+/, ' ')
#   end

#   def self.fix_the_damn_brs(html_string)
#     html_string.gsub(/<br \/>{1}/, "\n")
#   end

# end