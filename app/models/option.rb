class Option < ActiveRecord::Base
  attr_accessible :value

  belongs_to :trait

  has_many :user_traits, dependent: :destroy

  validates :value, presence: true
end
