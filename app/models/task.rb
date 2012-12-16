class Task < CustomizableItem
  attr_accessible :material, :name, :step_id, :is_finalized, :questions_attributes

  validates :name, presence: true
  validates :material, presence: true

  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |q| q[:text].blank? }, :allow_destroy => true

  belongs_to :step

  has_many :exons, dependent: :destroy
  accepts_nested_attributes_for :exons, :allow_destroy => true

  def personalizable_content
    material
  end

end
