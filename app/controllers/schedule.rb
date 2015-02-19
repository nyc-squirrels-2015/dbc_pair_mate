require "json"

get '/group/:id/schedule' do |id|
  if current_user == nil
    redirect '/'
  else
    schedules = StudentSchedule.select( "student_schedules.*").joins(:schedule)
                                  .where( :student_schedules =>{group_id: id, pair_student_id: nil},
                                          :schedules=> {start_datetime: Time.now..(Time.now.midnight+14.day)})

    @listings = group_by_date_of_week(schedules)
    @group_id = id;
    erb :view_schedules
  end
end


post '/group/:id/schedule/delete.json/:s_id' do |id,s_id|
  if current_user == nil
    return 401 #not authorized
  end

  content_type :json
  begin
    schedule = StudentSchedule.find(s_id);
  rescue Exception => e
    print e;
    return 404#not found
  end

  if schedule.student.id == current_user.id
    schedule.delete_this_record
  else
     return 401 #not authorized
  end
  {path: "/group/#{id}/schedule"}.to_json
end

post '/group/:id/schedule/accept.json/:s_id' do |id,s_id|
  if current_user == nil
    return 401 #not authorized
  end

  content_type :json

  begin
    schedule = StudentSchedule.find(s_id);
  rescue Exception => e
    print e;
    return 404#not found
  end

  if(schedule.pair_student == nil)
    schedule.pair_student = current_user
    schedule.save
  end

  {path: "/group/#{id}/schedule"}.to_json
end


post '/group/:id/schedule/new.json' do |group_id|
  if current_user == nil
    return 401 #not authorized
  end
  details = JSON.parse(params[:timeslot]);

  content_type :json
  begin
    st_time = DateTime.strptime(details["unparsedString"], '%m/%d %I:%M %p')
    end_time = st_time + 1.hour
    agenda = details["agenda"]
    p "st_time: #{st_time}"

    schedule = StudentSchedule.create_new(current_user, st_time,end_time, agenda, group_id);
  rescue Exception => e
    print e;
    return {error: e.to_s}.to_json
  end

  {path: "/group/#{group_id}/schedule"}.to_json
end
