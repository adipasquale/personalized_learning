class Question < CustomizableItem
  attr_accessible :text, :task_id, :questionnaire_id, :choices_attributes

  # belongs to either a task or a questionnaire
  belongs_to :task
  belongs_to :questionnaire

  has_many :choices, dependent: :destroy

  accepts_nested_attributes_for :choices, :reject_if => lambda { |c| c[:text].blank? }, :allow_destroy => true

  has_many :introns, dependent: :destroy
  accepts_nested_attributes_for :introns, :allow_destroy => true

end
