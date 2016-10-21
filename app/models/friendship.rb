class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  before_save :default_data
  def default_data
    self.accepted =  false
  end
end
