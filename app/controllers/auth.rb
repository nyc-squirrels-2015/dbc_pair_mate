@error = nil

get '/' do
  erb :welcome
end

get '/login' do
  if params[:error]
    @error = "Invalid email and/or password"
  end
  erb :login
end

get '/logout' do
  session.clear
  redirect '/'
end

post '/login' do
  student = Student.find_by({email: params[:student][:email]})

  if (student == nil || !student.authenticate(params[:student][:password]))

    redirect '/login?error=1'
  else
    session[:user_id] = student.id
    redirect "/group/#{student.group.id}/schedule"
  end
end


get '/signup' do
  @groups = Group.all
  if params[:error]
    @error = "Invalid account information is provided. Please check your entries and try again"
  end
  erb :signup
end

post '/signup' do

  begin
    #verify that password and confirmation password match
    #verify that all info is provided
    params[:student].delete("confirmpassword")
    student = Student.create(params[:student]);
    redirect "/group/#{student.group.id}/schedule"
  rescue Exception => e
    p e
    redirect '/signup?error=2'
  end
end
