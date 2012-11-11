class Question < ActiveRecord::Base
  attr_accessible :task_id, :text, :choices_attributes

  belongs_to :task

  has_many :choices, dependent: :destroy

  accepts_nested_attributes_for :choices, :reject_if => lambda { |c| c[:text].blank? }, :allow_destroy => true


end
