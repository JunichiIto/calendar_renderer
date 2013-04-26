require 'date'

class CalendarRenderer
  def self.render(year, month)
    sun_to_sat = "Su Mo Tu We Th Fr Sa"
    first_date = Date.new(year, month, 1)
    (
      # Header
      [first_date.strftime("%B %Y").center(sun_to_sat.size).rstrip, sun_to_sat] +
      # Body
      (first_date..first_date.next_month.prev_day).to_a.inject([]) {|weeks, date|
        weeks << Array.new(7, "  ") if weeks.empty? or date.sunday?
        weeks.tap {|weeks| weeks.last[date.wday] = date.strftime("%e") }
      }.map {|week| week.join(" ").rstrip }
    ).join("\n")
  end
end
