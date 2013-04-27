require 'date'

class CalendarRenderer
  DAY_LENGTH = 3
  WEEK_LENGTH = DAY_LENGTH * 7
  INDENT_LENGTH = 1
  MONTH_RANGE = 1..31
  WEEK_COUNT_IN_MONTH = 5

  def initialize(year, month)
    @first_date = Date.new(year, month, 1)
  end

  def to_s
    (header_rows + body_rows).join("\n")
  end

  private

  def body_rows
    first_week_offset = WEEK_LENGTH - @first_date.wday * DAY_LENGTH
    split_template = "a#{first_week_offset}" + "a#{WEEK_LENGTH}" * WEEK_COUNT_IN_MONTH

    this_month_calendar.unpack(split_template).tap {|rows|
      rows[0] = rows[0].rjust(WEEK_LENGTH)
    }
  end

  def this_month_calendar
    full_length_calendar[0..this_month_length]
  end

  def this_month_length
    last_date.day * DAY_LENGTH - 1
  end

  def last_date
    @first_date.next_month.prev_day
  end

  def full_length_calendar
    MONTH_RANGE.to_a.map{|i| i.to_s.rjust(DAY_LENGTH) }.join
  end

  def header_rows
    month_year = @first_date.strftime("%B %Y").center(WEEK_LENGTH + INDENT_LENGTH).rstrip
    sun_to_sat = " Su Mo Tu We Th Fr Sa"
    [month_year, sun_to_sat]
  end
end
