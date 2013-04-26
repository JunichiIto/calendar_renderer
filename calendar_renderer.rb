require 'date'

class CalendarRenderer
  def initialize(year, month)
    @first_date = Date.new(year, month, 1)
  end

  def to_s
    sun_to_sat = "Su Mo Tu We Th Fr Sa"
    month_year = @first_date.strftime("%B %Y").center(sun_to_sat.size).rstrip
    header_rows = [month_year, sun_to_sat]

    last_date = @first_date.next_month.prev_day
    dates_in_month = (@first_date..last_date).to_a

    weeks_in_month = dates_in_month.inject([]) {|weeks, date|
      weeks << [] if weeks.empty? or date.sunday?
      weeks.tap {|weeks| weeks.last[date.wday] = date }
    }

    format_row = -> week {
      week.map {|date| date.nil? ? "  " : date.strftime("%e") }.join(" ")
    }
    body_rows = weeks_in_month.map {|week| format_row.call(week) }

    (header_rows + body_rows).join("\n")
  end
end

