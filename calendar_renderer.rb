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
    to_string_row = -> week {
      # if Rails => week.map {|date| date.try(:strftime, "%e") || "  " }.join(" ")
      week.map {|date| date.nil? ? "  " : date.strftime("%e") }.join(" ")
    }
    weeks_in_month.map {|week| to_string_row.call(week) }.join("\n")
  end

  def weeks_in_month
    dates_in_month.inject([]) {|weeks, date|
      weeks << [] if weeks.empty? or date.sunday?
      weeks.tap {|week| week.last[date.wday] = date }
    }
  end

  def dates_in_month
    last_date = @first_date.next_month.prev_day
    (@first_date..last_date).to_a
  end
end

