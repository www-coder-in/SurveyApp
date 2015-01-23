# Home page
get '/' do

  erb :index
end

# Form for user registration
get '/register' do

  erb :register
end

# User registers and sees all their surveys (none)
post '/register' do

  redirect "/users/#{current_user.id}/surveys"
end

# Form for user log-in
get '/login' do

  erb :login
end

# User logs in and sees all their surveys
post '/login' do

  redirect "/users/#{current_user.id}/surveys"
end

get '/users/:user_id/surveys/:survey_id'

  erb :survey
end

# All surveys of a certain user
get '/users/:id/surveys' do
  @surveys = User.find(params[:id])
  erb :surveys
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