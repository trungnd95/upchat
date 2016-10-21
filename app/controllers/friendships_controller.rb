class FriendshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @friends =  current_user.friends
    @friends_request = current_user.friend_requests_received
    @not_friends1 =  User.not_current(current_user)
    @not_friends = []
    @not_friends1.each do |f|
        if !current_user.has_friend_requests?(f) && !current_user.has_friend_request_pending?(f) && !current_user.friend_with?(f)
          @not_friends.push(f)
        end
    end
  end

  def accept
    @user = User.find_by id: params[:user_request_id]
    current_user.accept_request @user
    # render json: current_user.accept_request(@user)
    flash[:info] = "You and #{@user.name} is friend"
    redirect_to friendships_path
  end

  def create
    @friendship = current_user.friendships.build friend_id: params[:friend_id]
    if @friendship.save
      flash[:success] =  "Added successfully. Waiting for acceptation!"
      redirect_to friendships_path
    else
      flash[:error] =  "Unable to add!"
      render action: :index
    end
  end
end
