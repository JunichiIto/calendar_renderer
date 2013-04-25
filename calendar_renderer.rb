require 'date'

class CalendarRenderer
  def render
    "#{header}#{body}"
  end

  private

  def header
   <<EOS
     April 2013
Su Mo Tu We Th Fr Sa
EOS
  end

  def body
    ret = ""
    month_table.each do |week|
      string_array = week.map do |date|
        date.nil? ? "  " : date.strftime("%e")
      end
      ret += "#{string_array.join(' ')}\n"
    end
    ret
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
    Date.new(2013, 4, 1)
  end

  def last_date
    Date.new(2013, 4, 30)
  end
end

