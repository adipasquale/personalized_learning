class Question < ActiveRecord::Base
  attr_accessible :task_id, :questionnaire_id, :text, :choices_attributes

  # belongs to either a task or a questionnaire
  belongs_to :task
  belongs_to :questionnaire

  has_many :choices, dependent: :destroy

  accepts_nested_attributes_for :choices, :reject_if => lambda { |c| c[:text].blank? }, :allow_destroy => true


end
