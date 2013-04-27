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
    full_length_calendar = MONTH_RANGE.to_a.map{|i| i.to_s.rjust(DAY_LENGTH) }.join
    
    first_date = Date.new(year, month, 1)
    last_date = Date.new(year, month, -1)
    
    # First Week Offset bytes
    first_week_offset = WEEK_LENGTH - first_date.wday * DAY_LENGTH
    
    # Last Day later delete dafault_cal
    month_length = last_date.day * DAY_LENGTH - 1
    this_month_calendar = full_length_calendar[0..month_length]
    
    # Generate Calendar Array
    template = "a#{first_week_offset}" + "a#{WEEK_LENGTH}" * WEEK_COUNT_IN_MONTH
    calendar_rows = this_month_calendar.unpack(template)
    
    # First Week -> slide
    calendar_rows[0] = calendar_rows[0].rjust(WEEK_LENGTH)
    
    # Print Calendar
    render_header(first_date) + calendar_rows.join("\n")
  end

  def render_header(first_date)
    month_year = first_date.strftime("%B %Y").center(WEEK_LENGTH + INDENT_LENGTH).rstrip
    sun_to_sat = " Su Mo Tu We Th Fr Sa"
    "#{month_year}\n#{sun_to_sat}\n"
  end
end
