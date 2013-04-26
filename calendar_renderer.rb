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
    month_year = first_date.strftime "%B %Y"
    "#{rtrim month_year.center(sun_to_sat.size)}\n#{sun_to_sat}"
  end

  def rtrim(str)
    str.gsub(/\s+$/, '')
  end

  def body
    month_table.map {|week| week_to_string(week) }.join("\n")
  end
  
  def week_to_string(week)
    week.map {|date| date.nil? ? "  " : date.strftime("%e") }.join(" ")
  end

  def month_table
    month_range.to_a.inject([]) {|table, date|
      table << [] if table.empty? or date.sunday?
      table.tap {|t| t.last[date.wday] = date }
    }
  end

  def month_range
    first_date..last_date
  end

  def first_date
    @first_date
  end

  def last_date
    @first_date.next_month.prev_day
  end
end

