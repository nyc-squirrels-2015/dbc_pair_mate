def current_user
  if session[:user_id]
    return Student.find(session[:user_id])
  else
    return nil
  end
end
