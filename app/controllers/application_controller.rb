class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice:'you should be signed in' unless current_user
  end

  def ensure_that_signed_in_as_admin
    redirect_to signin_path, notice:'you should be signed in' unless current_user
    redirect_to breweries_path, notice:'you should be admin' unless current_user.admin?
  end
end
