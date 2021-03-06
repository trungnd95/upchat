class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]

  def index
  end

  def show
    # if current_user.has_friend_requests? (User.last)
    #   render text: "#{current_user.name} has request form #{User.last.name} exception"
    # end
    render json: current_user.friend_of_mines
  end

  def new
    @user  = User.new
  end

  def create
    @user = User.new user_params
    respond_to do |format|
      if @user.save
        format.html  do
          redirect_to root_path, flash: {success: "Signed up successfully"}
        end
        format.json {render json: @user, status: :created}
      else
        format.html do
          flash[:error] = "Some thing went wrong!"
          render action: :new
        end
        format.json{render json: @user.errors, status: :unprocessable}
      end
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
