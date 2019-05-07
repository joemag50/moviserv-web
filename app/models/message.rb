class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  before_save :save_email

  def save_email
    self.email = User.find(self.user_id).email
  end
end
