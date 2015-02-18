require_relative '../spec_helper'

describe "Group model object" do
  let(:group1){Group.create({name: "Squirrels"})}

  let(:userJohn){Student.create({fname: "John", lname: "Smith", email: "js@gmail.com", password: "123", group: group1})}
  let(:userJenny ){ Student.create({fname: "Jenny", lname: "Portman", email: "jp@gmail.com", password: "123",group: group1})}

  let(:schedule1 ){ Schedule.create({start_datetime: "2015-03-03 17:00:00",
                                      end_datetime: "2015-03-03 18:00:00", agenda:"week 1 challenge 1"})}
  let(:schedule2 ){ Schedule.create({start_datetime: "2015-03-03 12:00:00",
                                    end_datetime: "2015-03-03 13:00:00", agenda:"week 1 challenge 1"})}
  let(:schedule3 ){ Schedule.create({start_datetime: "2015-03-03 12:00:00",
                                    end_datetime: "2015-03-03 13:00:00", agenda:"week 2 challenge 1"})}

  def create_schedules
    StudentSchedule.create({student: userJohn, schedule: schedule1, group: userJohn.group})
    StudentSchedule.create({student: userJohn, schedule: schedule2, group: userJohn.group})
    StudentSchedule.create({student: userJohn, schedule: schedule3, group: userJohn.group})
  end


  it 'should create new group' do
    Group.create({name: "TestGroup"});
    result = Group.find_by({name: "TestGroup"})
    expect(result).to_not be(nil)
  end

  it 'should return a list of schedules' do
    create_schedules
    expect(group1.schedules).not_to be_empty
  end

  it 'should update group name' do
    testGroup  = Group.create({name: "TestGroupUpdate"});
    Group.update(testGroup.id,{name: "Updated"})
    result = Group.find_by({name: "Updated"})
    expect(result).to_not be(nil)
  end

end
