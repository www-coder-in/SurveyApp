helpers do

  def current_user
        # p '-'*50
        puts session[:user_id]

        puts user_logged_in?

    @current_user ||= User.find(session[:user_id]) if user_logged_in?
  end

  def user_logged_in?
    session[:user_id] ? true : false
  end

def route_based_on_any_errors(action)
    if @user.id && @user.errors.size == 0
      p '-'*50
      puts "in route true"
      login
      redirect "/users/#{@user.id}/surveys"
    else
                    p '-'*50
      puts "in route false"
      @error_messages = @user.errors.full_messages
      erb :"#{action}"
    end
  end

  def login
    user = User.find_by(username: params[:input][:username])
          puts "found user"

    if user.password == params[:input][:password]
            puts "true login"

      session[:user_id] = user.id
      return true
    else
            puts "false login"

      return false
    end
  end

end