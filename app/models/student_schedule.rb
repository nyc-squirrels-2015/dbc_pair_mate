class StudentSchedule < ActiveRecord::Base
  belongs_to :student
  belongs_to :schedule
  belongs_to :group
  belongs_to :pair_student, class_name: "Student"

end
