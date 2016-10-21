class User < ApplicationRecord
  has_secure_password

  #relationship with message
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'
  #relationship with user
  has_many :friendships, dependent: :destroy
  has_many :friend_of_mines, through: :friendships, source: :friend
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id',
            dependent: :destroy
  has_many :friend_ofs, through: :inverse_friendships, source: :user

  #validate
  validates :name, presence: true
  validates :password, presence: true, length: {minimum: 6}

  # def received_messages
  #   Message.where(recipient: self)
  # end

  # def sent_messages
  #   Message.where(sender: self)
  # end

  scope :not_current, ->(current_user){where.not('email = ?', current_user.email)}

  def lasted_received_message n
    received_messages.order(created_at: :desc).limit n
  end

  def unread_messages
    received_messages.unread
  end

  def friends
    a = friend_of_mines.where("friendships.accepted = ?", true)
    b = friend_ofs.where("friendships.accepted = ?", true)
    a + b
  end

  def friend_requests_sent
    self.friend_of_mines.where("friendships.accepted = ?", false)
  end

  def friend_requests_received
    self.friend_ofs.where("friendships.accepted = ?", false)
  end

  def has_friend_requests? user
    self.friend_requests_received.where(id: user.id).count > 0
  end

  def has_friend_request_pending? user
    self.friend_requests_sent.where(id: user.id).count > 0
  end

  def friend_with? user
    self.friends.select{|f| f.id == user.id}.count > 0
  end

  def add_friend other_user
    friendships.create friend_id: other_user.id
  end

  def remove_friend other_user
    friendships.find_by(friend_id: other_user.id).destroy
  end

  def accept_request user
    self.inverse_friendships.where(user_id: user.id).update_all(accepted: true)
  end
end
