class Question < CustomizableItem
  attr_accessible :text, :task_id, :questionnaire_id, :choices_attributes

  # belongs to either a task or a questionnaire
  belongs_to :task
  belongs_to :questionnaire

  has_many :choices, dependent: :destroy

  accepts_nested_attributes_for :choices, :reject_if => lambda { |c| c[:text].blank? }, :allow_destroy => true

  has_many :introns, dependent: :destroy
  accepts_nested_attributes_for :introns, :allow_destroy => true

  has_many :answers, dependent: :destroy

  delegate :introns, to: :task

  def has_any_nested_introns?
    !introns.empty? or choices.any? { |c| !c.introns.empty? }
  end

  def personalizable_content
    text
  end

end
