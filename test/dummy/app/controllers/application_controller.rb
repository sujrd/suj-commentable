class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  
  def set_locale
    I18n.locale = params[:locale]
  end

  def default_url_options(options={})
    {:locale => I18n.locale}
  end

  # Override this method to return the user model used to create comments and rate
  # comments.
  def commentable_user
    Author.first
  end

end
