require 'date'

class CalendarRenderer
  DAY_LENGTH = 3
  WEEK_LENGTH = DAY_LENGTH * 7

  def initialize(year, month)
    @first_date = Date.new(year, month, 1)
  end

  def to_s
    (header_rows + body_rows).join("\n")
  end

  private

  def body_rows
    target_month_calendar.scan(sprit_regex)
  end

  def sprit_regex
    Regexp.new(".{#{DAY_LENGTH},#{WEEK_LENGTH}}")
  end

  def target_month_calendar
    first_week_offset + (1..last_date.day).to_a.map{|i| i.to_s.rjust(DAY_LENGTH) }.join
  end

  def first_week_offset
    ' ' * @first_date.wday * DAY_LENGTH
  end

  def last_date
    @first_date.next_month.prev_day
  end

  def header_rows
    [month_year, " Su Mo Tu We Th Fr Sa"]
  end

  def month_year
    indent_length = 1
    @first_date.strftime("%B %Y").center(WEEK_LENGTH + indent_length).rstrip
  end
end
