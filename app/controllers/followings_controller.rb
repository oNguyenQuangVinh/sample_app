class FollowingsController < ApplicationController
  before_action :load_user_follow, only: :index

  def index
    @title = t ".following"
    @users = @user.following.paginate page: params[:page]
    render "users/show_follow"
  end
end
