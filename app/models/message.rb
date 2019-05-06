class Message < ApplicationRecord
  belongs_to :user

  before_save :save_email

  def save_email
    self.email = User.find(self.user_id).email
  end
end
