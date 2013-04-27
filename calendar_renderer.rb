require 'date'

class CalendarRenderer
  DAY_LENGTH = 3
  WEEK_LENGTH = DAY_LENGTH * 7
  INDENT_LENGTH = 1

  def initialize(year, month)
    @year = year
    @month = month
  end

  def to_s
    render(@year, @month)
  end

  private

  def render(year, month)
    ret = ''
    
    t = Date.new(year,month) 
    
    # Calendar day's String is 93 bytes.
    default_cal = "  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31"
    
    # Get the Month's Fist Day
    first_day = Date.new(t.year, t.month, 1)
    
    # Get the Month's Last Day
    last_day = Date.new(t.year, t.month, -1).day
    
    # Print Header
    ret += t.strftime("%B %Y").center(WEEK_LENGTH + INDENT_LENGTH).rstrip
    ret += "\n"
    ret += " Su Mo Tu We Th Fr Sa\n"
    
    # First Week Offset bytes
    offset = WEEK_LENGTH - (first_day.strftime("%w").to_i * DAY_LENGTH)
    
    # Last Day later delete dafault_cal
    default_cal.slice!(last_day * DAY_LENGTH, default_cal.length - last_day * DAY_LENGTH)
    
    # Generate Calendar Array
    cal = default_cal.unpack("a#{offset}a#{WEEK_LENGTH}a#{WEEK_LENGTH}a#{WEEK_LENGTH}a#{WEEK_LENGTH}a*")
    
    # First Week -> slide
    cal[0] = cal[0].rjust(WEEK_LENGTH)
    
    # Print Calendar
    ret += cal.join("\n")

    ret
  end
end
