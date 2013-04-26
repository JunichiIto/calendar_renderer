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
    month_year_centered_and_trimmed = month_year.center(sun_to_sat.length).gsub(/\s+$/, '')
    "#{month_year_centered_and_trimmed}\n#{sun_to_sat}"
  end

  def body
    ret = []
    month_table.each do |week|
      string_array = week.map do |date|
        date.nil? ? "  " : date.strftime("%e")
      end
      ret << "#{string_array.join(' ')}"
    end
    ret.join("\n")
  end

  def month_table
    table = []
    week = []
    table << week
    month_range.each do |date|
      week[date.wday] = date
      if (date.wday == 6)
        week = []
        table << week
      end
    end
    table
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

