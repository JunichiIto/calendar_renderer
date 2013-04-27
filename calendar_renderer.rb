require 'date'

class CalendarRenderer
  def self.render(year, month)
    day_length = 3
    week_length = day_length * 7
    first_date = Date.new(year, month, 1)
    indent_length = 1
    week_count_in_month = 5

    month_year = first_date.strftime("%B %Y").center(week_length + indent_length).rstrip
    sun_to_sat = " Su Mo Tu We Th Fr Sa"
    header_rows = [month_year, sun_to_sat]

    first_week_offset = week_length - first_date.wday * day_length
    split_template = "a#{first_week_offset}" + "a#{week_length}" * week_count_in_month

    last_date = first_date.next_month.prev_day
    this_month_length = last_date.day * day_length - 1
    full_length_calendar = (1..31).to_a.map{|i| i.to_s.rjust(day_length) }.join
    this_month_calendar = full_length_calendar[0..this_month_length]
    body_rows = this_month_calendar.unpack(split_template).tap {|rows|
      rows[0] = rows[0].rjust(week_length)
    }

    (header_rows + body_rows).join("\n")
  end
end
