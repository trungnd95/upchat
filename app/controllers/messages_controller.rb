class MessagesController < ApplicationController
  before_action :logged_in_user

  def sent
    @messages =  current_user.sent_messages
  end

  def received
    @messages = current_user.received_messages
  end

  private
  def message_params
    params.require(:message).permit :body, :read_at, :sender_id, :recipient_id
  end
end
