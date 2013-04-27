require 'date'

class CalendarRenderer
  def self.render(year, month)
    day_length = 3
    week_length = day_length * 7
    first_date = Date.new(year, month, 1)
    indent_length = 1
    week_count_in_month = 5

    (
      [first_date.strftime("%B %Y").center(week_length + indent_length).rstrip, " Su Mo Tu We Th Fr Sa"] +
      ((1..31).to_a.map{|i| i.to_s.rjust(day_length) }.join)[0..(first_date.next_month.prev_day.day * day_length - 1)].unpack("a#{week_length - first_date.wday * day_length}" + "a#{week_length}" * week_count_in_month).tap {|rows|
        rows[0] = rows[0].rjust(week_length)
      }
    ).join("\n")
  end
end
