require 'spec_helper'

describe "Authorization controller" do


  let(:group) {Group.create(name: "Moose")}
  let(:student) {Student.create(fname: "Bill", lname:"Thompson", email: "bt@email.com", password: "123", group_id:group.id)}


  describe "GET /signup" do
    it "displays the signup page" do
      get '/signup'
      expect(last_response).to be_ok
    end
    it "displays error in signup page" do
      get '/signup?error=1'
      expect(last_response).to be_ok
      expect(last_response.body.include?('Invalid')).to be(true)
    end
  end

  describe "GET /login" do
    it "loads the login page" do
      get '/login'
      expect(last_response).to be_ok
    end
    it "displays error in the login page" do
      get '/login?error=2'
      expect(last_response).to be_ok
      expect(last_response.body.include?('Invalid')).to be(true)
    end
  end

  describe "GET /logout"  do
    it "logs out the user and clears the session" do
      get '/logout'
      follow_redirect!
      last_request.path.should == '/'
    end
  end

  describe "POST /signup" do
    it "should successfully redirect after user created" do
      post '/signup', params={student: {fname: "Jenny", lname: "Portman", email: "jp@gmail.com", password: "123",group_id: group.id}}
      expect(last_response).to be_redirect
      follow_redirect!
      last_request.path.should == "/group/#{group.id}/schedule"
  end
 end
end
