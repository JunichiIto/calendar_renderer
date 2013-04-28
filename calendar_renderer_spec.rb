require 'rspec'
require './calendar_renderer'

describe CalendarRenderer do
  CALENDAR_APRIL_2013 = <<EOS
      April 2013
 Su Mo Tu We Th Fr Sa
     1  2  3  4  5  6
  7  8  9 10 11 12 13
 14 15 16 17 18 19 20
 21 22 23 24 25 26 27
 28 29 30
EOS
  subject { CalendarRenderer.render(2013, 4) }

  specify {
    expect(subject).to eq CALENDAR_APRIL_2013.rstrip
  }
end
