class Questionnaire < ActiveRecord::Base
  attr_accessible :name, :step_id

  validates :name, presence: true
end
