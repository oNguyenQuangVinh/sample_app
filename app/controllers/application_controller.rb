class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include ApplicationHelper

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t ".msg_login"
      redirect_to login_url
    end
  end

  def load_user_follow
    @user  = User.find_by id: params[:user_id]
    render_404 unless @user
  end
end
