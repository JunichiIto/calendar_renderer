require 'date'

class CalendarRenderer
  def self.render(year, month)
    first_date = Date.new(year, month, 1)
    day_length = 3
    week_length = day_length * 7
    indent_length = 1

    ([first_date.strftime("%B %Y").center(week_length + indent_length).rstrip, " Su Mo Tu We Th Fr Sa"] + (' ' * first_date.wday * day_length +(1..first_date.next_month.prev_day.day).map{|i| i.to_s.rjust(day_length) }.join).scan(/.{#{day_length},#{week_length}}/)).join("\n")
  end
end
