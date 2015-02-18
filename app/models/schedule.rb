class Schedule < ActiveRecord::Base

  def formatTimeSlot
      #%d/%m/%Y
      textOut = start_datetime.strftime("%H:%M")
      textOut<<" - "
      textOut << end_datetime.strftime("%H:%M")
  end

  def to_date_of_week
     weekDay = start_datetime.strftime("%A")
     weekDay<< " ("<<start_datetime.strftime("%m/%d")<<")"
  end
end
