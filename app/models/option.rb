class Option < ActiveRecord::Base
  attr_accessible :value

  belongs_to :trait

  validates :value, presence: true
end
