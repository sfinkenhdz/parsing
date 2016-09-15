require 'net/http'
require 'nokogiri'
require 'uri'
require_relative 'page_parser'

class Page
  attr_reader :body_string, :list_items, :all_p_tags

  def initialize(url)
    PageParser.convert(url)
    @body_string = PageParser.create_body
    @list_items = PageParser.create_list_items
    @all_p_tags = PageParser.create_p_tags
  end

  def find_email
    @emails = @body_string.scan(/\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b/).uniq!
  end

  def find_phone_numbers
    @phone_nos = @body_string.scan(/\b[\s()\d-]{6,}\d\b/)
  end

  def format_list_items
    @split_list_items = list_items.map!{|item|
      item.gsub!(/[^\w\d()-@.]/," ")
      #This gets rid of &nbws. Direct gsub wasn't working. It isn't white space (\s), a digit(\d) or a word(\W)
      item.gsub!(/,/, " ")
      item.split
    }
    @split_list_items
  end

  def format_all_p_tags
    @split_ptags = all_p_tags.map!{|item|
      item.gsub!(/[^\w\d()-@.]/," ")
      #This gets rid of &nbws. Direct gsub wasn't working. It isn't white space (\s), a digit(\d) or a word(\W)
      item.gsub!(/,/, " ")
      item.split
    }
    @split_ptags
  end

  def get_rid_of_non_contact_info_ptags
    format_all_p_tags
    @contact_info_p = []
    @split_ptags.each do |sub_array|
      if sub_array.any?{|element| element.match(EMAIL_MATCH)} || sub_array.any?{|element| element.match(PHONE_NUM_MATCH)}
        @contact_info_p << sub_array
      end
    end
    p @contact_info_p
  end

  def get_rid_of_non_contact_info
    format_list_items
    @contact_info = []
    @split_list_items.each do |sub_array|
      if sub_array.any?{|element| element.match(EMAIL_MATCH)} || sub_array.any?{|element| element.match(PHONE_NUM_MATCH)}
        @contact_info << sub_array
      end
    end
    @contact_info
  end

  private

  EMAIL_MATCH = /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b/
  PHONE_NUM_MATCH = /\b[\s()\d-]{6,}\d\b/

end



#Will email addresses frequently/always be links?
    # @links = @noko_doc.css("article a").map {|link| link["href"]}
#Will email addresses, and associated info frequently/always be in a list?


