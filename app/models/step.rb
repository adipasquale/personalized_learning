class Step < ActiveRecord::Base
  attr_accessible :name, :order

  has_many :users
  has_many :tasks
  has_many :questionnaires

  validates :name, presence: true, uniqueness: true
  validates :order, presence: true, uniqueness: true
end
