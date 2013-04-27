require 'date'

class CalendarRenderer
  DAY_LENGTH = 3
  WEEK_LENGTH = DAY_LENGTH * 7
  INDENT_LENGTH = 1
  MONTH_RANGE = 1..31

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
    default_cal = MONTH_RANGE.to_a.map{|i| i.to_s.rjust(DAY_LENGTH) }.join
    
    # Get the Month's Fist Day
    first_date = Date.new(t.year, t.month, 1)
    
    # Get the Month's Last Day
    last_date = Date.new(t.year, t.month, -1)
    
    # Print Header
    ret += t.strftime("%B %Y").center(WEEK_LENGTH + INDENT_LENGTH).rstrip
    ret += "\n"
    ret += " Su Mo Tu We Th Fr Sa\n"
    
    # First Week Offset bytes
    offset = WEEK_LENGTH - (first_date.strftime("%w").to_i * DAY_LENGTH)
    
    # Last Day later delete dafault_cal
    default_cal.slice!(last_date.day * DAY_LENGTH, default_cal.length - last_date.day * DAY_LENGTH)
    
    # Generate Calendar Array
    cal = default_cal.unpack("a#{offset}a#{WEEK_LENGTH}a#{WEEK_LENGTH}a#{WEEK_LENGTH}a#{WEEK_LENGTH}a*")
    
    # First Week -> slide
    cal[0] = cal[0].rjust(WEEK_LENGTH)
    
    # Print Calendar
    ret += cal.join("\n")

    ret
  end
end
