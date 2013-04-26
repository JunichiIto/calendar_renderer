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
    month_year = @first_date.strftime("%B %Y").center(sun_to_sat.size).rstrip
    "#{month_year}\n#{sun_to_sat}"
  end

  def body
    to_string_line = -> week {
      week.map {|date| date.nil? ? "  " : date.strftime("%e") }.join(" ")
    }
    month_table.map {|week| to_string_line.call(week) }.join("\n")
  end

  def month_table
    dates_in_month.inject([]) {|table, date|
      table << [] if table.empty? or date.sunday?
      table.tap {|t| t.last[date.wday] = date }
    }
  end

  def dates_in_month
    last_date = @first_date.next_month.prev_day
    (@first_date..last_date).to_a
  end
end

