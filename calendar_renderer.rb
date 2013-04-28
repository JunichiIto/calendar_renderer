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
    split_pattern = /.{#{DAY_LENGTH},#{WEEK_LENGTH}}/
    body_text.scan(split_pattern)
  end

  def body_text
    first_week_offset + target_month_calendar
  end

  def first_week_offset
    ' ' * @first_date.wday * DAY_LENGTH
  end

  def target_month_calendar
    last_day = @first_date.next_month.prev_day.day
    (1..last_day).to_a.map{|i| i.to_s.rjust(DAY_LENGTH) }.join
  end

  def header_rows
    [month_year, " Su Mo Tu We Th Fr Sa"]
  end

  def month_year
    indent_length = 1
    @first_date.strftime("%B %Y").center(WEEK_LENGTH + indent_length).rstrip
  end
end
