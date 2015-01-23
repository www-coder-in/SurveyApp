helpers do

  def current_user
    @current_user ||= User.find(session[:user_id]) if user_logged_in?
  end

  def user_logged_in?
    session[:user_id] ? true : false
  end

  def reroute_if_not_logged_in(route)

  end

  def route_based_on_any_errors(action)
    if @user.id && @user.errors.size == 0
      login
      redirect "/users/#{@user.id}/surveys"
    else
      @error_messages = @user.errors.full_messages
      erb :"#{action}"
    end
  end

  def login
    user = User.find_by(username: params[:input][:username])
    if user.password == params[:input][:password]
      session[:user_id] = user.id
      return true
    else
      return false
    end
  end

end