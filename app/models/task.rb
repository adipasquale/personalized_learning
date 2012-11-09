class Task < ActiveRecord::Base
  attr_accessible :material, :name

  validates :name, presence: true
  validates :material, presence: true

end
