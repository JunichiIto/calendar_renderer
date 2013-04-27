require 'date'

class CalendarRenderer
  DAY_LENGTH = 3
  WEEK_LENGTH = DAY_LENGTH * 7
  INDENT_LENGTH = 1
  MONTH_RANGE = 1..31
  WEEK_COUNT_IN_MONTH = 5

  def initialize(year, month)
    @year = year
    @month = month
  end

  def to_s
    render(@year, @month)
  end

  private

  def render(year, month)
    first_date = Date.new(year, month, 1)
    
    render_header(first_date) + calendar_rows(first_date).join("\n")
  end

  def calendar_rows(first_date)
    first_week_offset = WEEK_LENGTH - first_date.wday * DAY_LENGTH
    template = "a#{first_week_offset}" + "a#{WEEK_LENGTH}" * WEEK_COUNT_IN_MONTH
    rows = this_month_calendar(first_date).unpack(template)
    rows[0] = rows[0].rjust(WEEK_LENGTH)
    rows
  end

  def this_month_calendar(first_date)
    last_date = Date.new(first_date.year, first_date.month, -1)
    full_length_calendar = MONTH_RANGE.to_a.map{|i| i.to_s.rjust(DAY_LENGTH) }.join
    this_month_length = last_date.day * DAY_LENGTH - 1
    full_length_calendar[0..this_month_length]
  end

  def render_header(first_date)
    month_year = first_date.strftime("%B %Y").center(WEEK_LENGTH + INDENT_LENGTH).rstrip
    sun_to_sat = " Su Mo Tu We Th Fr Sa"
    "#{month_year}\n#{sun_to_sat}\n"
  end
end
