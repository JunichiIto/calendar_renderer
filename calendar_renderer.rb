require 'date'

class CalendarRenderer
  DAY_LENGTH = 3
  WEEK_LENGTH = DAY_LENGTH * 7

  def self.render(year, month)
    first_date = Date.new(year, month, 1)

    indent_length = 1
    month_year = first_date.strftime("%B %Y").center(WEEK_LENGTH + indent_length).rstrip
    sun_to_sat = " Su Mo Tu We Th Fr Sa"
    header_rows = [month_year, sun_to_sat]

    week_count_in_month = 5
    first_week_offset = WEEK_LENGTH - first_date.wday * DAY_LENGTH
    split_template = "a#{first_week_offset}" + "a#{WEEK_LENGTH}" * week_count_in_month

    last_date = first_date.next_month.prev_day
    this_month_length = last_date.day * DAY_LENGTH - 1
    full_length_calendar = (1..31).to_a.map{|i| i.to_s.rjust(DAY_LENGTH) }.join
    this_month_calendar = full_length_calendar[0..this_month_length]
    body_rows = this_month_calendar.unpack(split_template).tap {|rows|
      rows[0] = rows[0].rjust(WEEK_LENGTH)
    }

    (header_rows + body_rows).join("\n")
  end
end
