class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      flash[:info] = t ".msg_info"
      redirect_to root_url
    else
      flash.now[:danger] = t ".msg_danger_email"
      render :new
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t(".empty")
      render :edit
    elsif @user.update_attributes user_params
      log_in @user
      flash[:success] = t ".msg_succ"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    @user = User.find_by email: params[:email]
    render_404 unless @user
  end

  def valid_user
    unless  @user && @user.activated? &&
      @user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t "msg_danger_pass"
      redirect_to new_password_reset_url
    end
  end
end
