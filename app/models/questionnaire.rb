class Questionnaire < ActiveRecord::Base
  attr_accessible :name, :step_id, :questions_attributes

  validates :name, presence: true

  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |q| q[:text].blank? }, :allow_destroy => true

  belongs_to :step

end
