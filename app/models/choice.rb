class Choice < CustomizableItem
  attr_accessible :question_id, :right, :text, :label

  belongs_to :question

  has_many :answers, dependent: :destroy

  has_many :introns, dependent: :destroy
  accepts_nested_attributes_for :introns, :allow_destroy => true

  def personalizable_content
    text
  end

end
