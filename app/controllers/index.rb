# Home page
get '/' do
  erb :index
end

# Form for user registration
get '/register' do
  @error_messages = []
  erb :register
end

# User registers and sees all their surveys (none)
post '/register' do
  @user = User.create(params[:input])
  route_based_on_any_errors("register")
end

# Form for user log-in
get '/login' do

  @error_messages = []
  erb :login
end

# Reroutes to user based on if they're logged in
get '/users/surveys' do
  if current_user
    p '-'*50
    puts "true for current_user"
    redirect "/users/#{current_user.id}/surveys"
  else
    p '-'*50
    puts "false for current_user"
    redirect '/login'
  end
end

# User logs in and sees all their surveys
post '/login' do
  @user = User.find_by(username: params[:input][:username])
  route_based_on_any_errors("login")
  redirect "/users/#{current_user.id}/surveys"
end

# Logs out user
get '/logout' do
  session[:user_id] = nil
  erb :index
end

get '/users/:user_id/surveys/:survey_id' do

  erb :survey
end

# All surveys of a certain user
get '/users/:id/surveys' do
  if current_user
    @user = current_user
    @surveys = Survey.where(author_id: params[:id])
    erb :surveys
  else
    erb :login
  end
end

# Reroutes user to new survey form based on if they're logged in
get 'users/surveys/new' do
  if current_user
    erb :new_survey
  else
    erb :login
  end
end

# Form for certain user to create a new survey
get '/users/:id/surveys/new' do

  erb :new_survey
end

# User creates a new survey and sees new survey
post '/users/:id/surveys' do
  survey = Survey.create(params[:input])
  redirect "/users/#{current_user.id}/surveys/#{survey.id}"
end