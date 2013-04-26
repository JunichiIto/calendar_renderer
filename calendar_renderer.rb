require 'date'

class CalendarRenderer
  def initialize(year, month)
    @first_date = Date.new year, month, 1
  end

  def render
    "#{header}\n#{body}\n"
  end

  private

  def header
    sun_to_sat = "Su Mo Tu We Th Fr Sa"
    month_year = @first_date.strftime "%B %Y"
    rtrim = -> str { str.gsub(/\s+$/, '') }
    "#{rtrim.call(month_year.center(sun_to_sat.size))}\n#{sun_to_sat}"
  end

  def body
    date_to_s = -> date { date.nil? ? "  " : date.strftime("%e") }
    week_to_s = -> week { week.map {|date| date_to_s.call(date) }.join(" ") }
    month_table.map {|week| week_to_s.call(week) }.join("\n")
  end

  def month_table
    month_range.to_a.inject([]) {|table, date|
      table << [] if table.empty? or date.sunday?
      table.tap {|t| t.last[date.wday] = date }
    }
  end

  def month_range
    last_date = @first_date.next_month.prev_day
    @first_date..last_date
  end
end

