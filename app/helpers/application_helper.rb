# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

end
class String
  def cap  # String.capitalize doesn't account for acronyms or '(' in front
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

