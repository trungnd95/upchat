class MessagesController < ApplicationController
  before_action :logged_in_user

  def index
    @messages_sent = current_user.sent_messages
    @messages_received = current_user.received_messages
    @users = current_user.friends
  end

  def create
    @message =  current_user.sent_messages.new message_params
    if @message.save
      flash[:success] = "Message sent successfully"
      redirect_to messages_path
    else
      flash.now[:error] = "Some thing wrong . Message not send"
      redirect_to messages_path
    end
  end

  def update
    @message = Message.find params[:message_id]
    respond_to do |format|
      if @message.mark_as_read!
        format.json{render json: @message, status: :ok}
      else
        format.json{render json: {error: 'Something went wrong!'}, status: :unprocessable}
      end
    end
  end

  private
  def message_params
    params.require(:message).permit :body, :read_at, :sender_id, :recipient_id
  end
end
