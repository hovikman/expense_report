class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  rescue_from CanCan::AccessDenied do |exception|
    store_location
    if signed_in?
      redirect_to root_url, flash: { error: 'Access denied.' }
    else
      redirect_to signin_url, flash: { error: 'Access denied. Please sign in.' }
    end
  end
end
