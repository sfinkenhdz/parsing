module HTMLWhitespaceCleaner
  def self.clean(html_string)
    remove_all_white_space_between_tags(fix_the_damn_brs(condense_whitespace(html_string))).strip
  end

  private
  WHITE_SPACE_BETWEEN_TAGS = /(?<=>)\s+(?=<)/

  def self.remove_all_white_space_between_tags(html_string)
    html_string.gsub(WHITE_SPACE_BETWEEN_TAGS, "")
  end

  def self.condense_whitespace(html_string)
    html_string.gsub(/\s+/, ' ')
  end

  def self.fix_the_damn_brs(html_string)
    html_string.gsub(/<br \/>{1}/, "\n")
  end

end