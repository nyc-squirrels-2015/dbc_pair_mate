#group schedules by day of week
def group_by_date_of_week(schedules)
  map_out = {}

  schedules.each do |studentschedule|
    list = map_out.fetch(studentschedule.schedule.to_date_of_week, [])
    list<<studentschedule
    list.sort_by {|studentschedule| studentschedule.schedule.start_datetime}.reverse
    map_out[studentschedule.schedule.to_date_of_week] = list
  end
  map_out
end

def  check_user_session
  if !current_user
    redirect '/'
  end
end


