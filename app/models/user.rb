class User < ApplicationRecord
  has_secure_password

  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'

  validates :name, presence: true
  validates :password, presence: true, length: {minimum: 6}

  # def received_messages
  #   Message.where(recipient: self)
  # end

  # def sent_messages
  #   Message.where(sender: self)
  # end

  def lasted_received_message n
    received_messages.order(created_at: :desc).limit n
  end

  def unread_messages
    received_messages.unread
  end
end
