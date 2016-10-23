class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email params[:email]
    unless @user.nil?
      if @user.authenticate params[:password]
        session[:user_id] = @user.id
        redirect_to messages_path, flash: {success: "Welcome to Trung Manucian chat app"}
      else
        flash.now[:error] = "Some thing went wrong!. Permission denied"
        render action: :new
      end
    else
      flash[:error] = "User not found!"
      render action: :new
    end
  end

  def destroy
    session[:user_id] =  nil
    flash[:success] = "Logged out successfully"
    redirect_to root_path
  end
end
