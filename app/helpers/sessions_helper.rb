module SessionsHelper

  def sign_in(user, permanent)
    if permanent
      cookies.permanent[:remember_token] = user.remember_token
    else
      cookies[:remember_token] = user.remember_token
    end
    current_user = user
  end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
    session.delete(:return_to)
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end

  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default, notice: 'Signed in!')
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

  def set_expense_list_path(new_path)
    cookies[:expense_list_path] = new_path
  end
  
  def get_expense_list_path
    if cookies[:expense_list_path] != nil
      expense_list_path = cookies[:expense_list_path]
    else
      expense_list_path = submitted_expenses_path
    end
  end
end
