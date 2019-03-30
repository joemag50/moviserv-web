class User < ApplicationRecord
  # has_secure_password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def new_session
    self.token = User.new_token
    update_attribute(:token, self.token)
    self.token
  end

  def end_session
    update_attribute(:token, nil)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end
end
