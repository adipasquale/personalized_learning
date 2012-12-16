class Choice < CustomizableItem
  attr_accessible :question_id, :right, :text, :label

  belongs_to :question

  has_many :answers, dependent: :destroy

  has_many :exons, dependent: :destroy
  accepts_nested_attributes_for :exons, :allow_destroy => true

  delegate :exons, to: :question

  def personalizable_content
    text
  end

end
