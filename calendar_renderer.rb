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
    target_month_calendar.unpack(split_template).tap {|rows| rows[0] = rows[0].rjust(WEEK_LENGTH) }
  end

  def split_template
    week_count_in_month = 5
    "a#{first_week_offset}" + "a#{WEEK_LENGTH}" * week_count_in_month
  end

  def first_week_offset
    WEEK_LENGTH - @first_date.wday * DAY_LENGTH
  end

  def target_month_calendar
    full_length_calendar[0..target_month_length]
  end

  def target_month_length
    last_date.day * DAY_LENGTH - 1
  end

  def last_date
    @first_date.next_month.prev_day
  end

  def full_length_calendar
    (1..31).to_a.map{|i| i.to_s.rjust(DAY_LENGTH) }.join
  end

  def header_rows
    [month_year, " Su Mo Tu We Th Fr Sa"]
  end

  def month_year
    indent_length = 1
    @first_date.strftime("%B %Y").center(WEEK_LENGTH + indent_length).rstrip
  end
end
