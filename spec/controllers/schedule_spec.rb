require 'spec_helper'

describe "Schedule Controller" do


  let(:group) {Group.create(name: "Moose")}
  let(:student) {Student.create(fname: "Bill", lname:"Thompson", email: "bt@email.com", password: "123", group_id:group.id)}

  describe "GET /group/id/schedule" do
    it "redirects to home page when user not logged in" do
      get "/group/#{group.id}/schedule"
      expect(last_response).to be_redirect
    end

  end

  describe "GET /group/id/schedule " do
    it "displays the list of schedules" do
      get "/group/#{group.id}/schedule",  {}, {'rack.session' =>  { :user_id => student.id } }

      expect(last_response).to be_ok
      expect(last_response.body.include?('Date Listing')).to be(true)
    end

  end

end
