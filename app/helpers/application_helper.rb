# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def cap(str)  # String.capitalize doesn't account for acronyms, '(' in front
    return '' if str.empty?
    str.first == '(' ? '(' + cap(str[1..-1]) : str.first.upcase + str[1..-1]
  end
  def titleizev2(str)  # String.titleize doesn't account for acronyms, special words
    return '' if str.empty?
    lcase_list = "of etc and by the for on is at to but nor or a via Of Etc And By The For On Is At To But Nor Or A Via"
    first, *rest = str.split(' ')
    cap(first) + (rest.map { |w| ' ' + (lcase_list.include?(w) ? w.downcase : w.cap) }).join
  end
  class String # This is no longer being loaded??!!!
    def cap  # String.capitalize doesn't account for acronyms, '(' in front
      return '' if self.empty?
      self.first == '(' ? '(' + self[1..-1].cap : self.first.upcase + self[1..-1]
    end
    def titleizev2  # String.titleize doesn't account for acronyms, special words
      return '' if self.empty?
      lcase_list = "of etc and by the for on is at to but nor or a via Of Etc And By The For On Is At To But Nor Or A Via"
      first, *rest = self.split(' ')
      first.cap + (rest.map { |w| ' ' + (lcase_list.include?(w) ? w.downcase : w.cap) }).join
    end

  # def each_upcase
  #   self.split(' ').map {|w| w.capitalize }.join(' ')
  # end
  end
end
