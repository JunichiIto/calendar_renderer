require 'date'

class CalendarRenderer
  def initialize(year, month)
    @first_date = Date.new(year, month, 1)
  end

  def to_s
    calendar_rows.join("\n")
  end

  private

  def calendar_rows
    header_rows + body_rows
  end

  def header_rows
    sun_to_sat = "Su Mo Tu We Th Fr Sa"
    month_year = @first_date.strftime("%B %Y").center(sun_to_sat.size).rstrip
    [month_year, sun_to_sat]
  end

  def body_rows
    format_row = -> week {
      # if Rails => week.map {|date| date.try(:strftime, "%e") || "  " }.join(" ")
      week.map {|date| date.nil? ? "  " : date.strftime("%e") }.join(" ")
    }
    weeks_in_month.map {|week| format_row.call(week) }
  end

  def weeks_in_month
    dates_in_month.inject([]) {|weeks, date|
      weeks << [] if weeks.empty? or date.sunday?
      weeks.tap {|weeks| weeks.last[date.wday] = date }
    }
  end

  def dates_in_month
    # if Rails => (@first_date..@first_date.end_of_month).to_a
    last_date = @first_date.next_month.prev_day
    (@first_date..last_date).to_a
  end
end

