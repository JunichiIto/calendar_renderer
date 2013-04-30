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
    first_week_offset + calendar_text
  end

  def first_week_offset
    ' ' * @first_date.wday * DAY_LENGTH
  end

  def calendar_text
    last_day = @first_date.next_month.prev_day.day
    rjust_all 1..last_day
  end

  def header_rows
    [month_year, sun_to_sat]
  end

  def month_year
    indent_length = 1
    @first_date.strftime("%B %Y").center(WEEK_LENGTH + indent_length).rstrip
  end

  def sun_to_sat
    rjust_all %w(Su Mo Tu We Th Fr Sa)
  end

  def rjust_all(enum)
    enum.to_a.map{|e| e.to_s.rjust(DAY_LENGTH) }.join
  end
end
