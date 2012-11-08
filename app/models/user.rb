class User < ActiveRecord::Base
  attr_accessible :is_admin, :login, :user_traits_attributes

  before_save :create_remember_token

  has_many :user_traits, dependent: :destroy

  validates :login, presence: true, uniqueness: true

  accepts_nested_attributes_for :user_traits

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
