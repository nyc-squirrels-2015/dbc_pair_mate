Model:

Group
  name
Student
  fname
  lname
  email
  group
  password_digest

Schedule
  start_datetime
  end_datetime
  agenda


UserSchedules
  user
  schedule
  group
  accepted_by_user
  is_cancelled

  ----------
  In rails 4, when using postgresql, you can just write

add_reference :post, :author, references: :users
This will create a column author_id, which correctly refers to users(id).

And in your model, you write

belongs_to :author, class_name: "User"


  StudentSchedule.select( "student_schedules.*").joins(:schedule).where( :studentSchedules =>{group_id: 1},
                                                                                  :schedules=> {start_datetime: Time.now..(Time.now.midnight+14.day)});
