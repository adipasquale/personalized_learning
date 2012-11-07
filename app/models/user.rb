class User < ActiveRecord::Base
  attr_accessible :is_admin, :login

  before_save :create_remember_token

  validates :login, presence: true, uniqueness: true

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
