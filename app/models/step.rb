class Step < ActiveRecord::Base
  attr_accessible :name, :sequence_order

  has_many :users
  has_many :tasks
  has_many :questionnaires

  validates :name, presence: true, uniqueness: true
  validates :sequence_order, presence: true, uniqueness: true

  default_scope order('sequence_order ASC')

end