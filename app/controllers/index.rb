# Home page
get '/' do
  erb :index
end

# Form for user registration
get '/register' do
  if current_user
    redirect "/users/#{current_user.id}/surveys"
  else
    @error_messages = []
    erb :register
  end
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
    redirect "/users/#{current_user.id}/surveys"
  else
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

# Form for certain user to create a new survey
get '/users/:id/surveys/new' do
  @error_messages = []
  @user = current_user
  erb :new_survey
end

get '/users/:user_id/surveys/:survey_id' do
  @survey = Survey.find(params[:survey_id])
  @user = current_user

  @questions = @survey.questions
  erb :survey
end

# All surveys of a certain user
get '/users/:id/surveys' do
  if current_user
    @user = current_user
    if Survey.where(author_id: params[:id])
      @surveys = Survey.where(author_id: params[:id])
    else
      @surveys = []
    end
    erb :surveys
  else
    @error_messages=[]
    erb :login
  end
end

# Reroutes user to new survey form based on if they're logged in
get '/users/surveys/new' do
  if current_user
    redirect "/users/#{current_user.id}/surveys/new"
  else
    erb :login
  end
end

# User creates a new survey and sees new survey
post '/users/:id/surveys' do
  survey = Survey.create(title: params[:title], author_id: current_user.id)
  redirect "/users/#{current_user.id}/surveys/#{survey.id}"
end

# Adds new question to a certain survey
post '/users/:user_id/surveys/:survey_id/questions/new' do
  question = Question.create(params[:input])
  Response.create(question_id: question.id, survey_id: params[:survey_id], choice_id: 0)

  @survey = Survey.find(params[:survey_id])
  @user = current_user
  @questions = @survey.questions

  redirect "/users/#{current_user.id}/surveys/#{@survey.id}"
end

#List the question and add choices to it
get '/users/
:user_id/surveys/:survey_id/questions/:question_id/choices' do
  puts '-'*50
  puts 'in route'
  @survey = Survey.find(params[:survey_id])
  @question = Question.find(params[:question_id])
  if @question.choices
    @choices = []
  else
    @choices = @question.choices
  end
erb :choices

end

# List the question and add choices to it
get '/users/:user_id/surveys/:survey_id/questions/:question_id/choices' do
  @survey = Survey.find(params[:survey_id])
  @question = Question.find(params[:question_id])
  if @question.choices
        puts '-'*50
  puts 'in route'
    @choices = @question.choices
  else
    @choices = []
  end
erb :choices

end

# Adds choices to a certain question
post '/users/:user_id/surveys/:survey_id/questions/:question_id/choices/new' do

  choice = Choice.create(params[:input])
  Response.create(question_id: params[:question_id], survey_id: params[:survey_id], choice_id: choice.id)
  #   puts '-'*50
  # puts 'in route'

 redirect "/users/#{params[:user_id]}/surveys/#{params[:survey_id]}/questions/#{params[:question_id]}/choices"
end
