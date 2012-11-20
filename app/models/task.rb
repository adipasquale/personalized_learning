class Task < CustomizableItem
  attr_accessible :material, :name, :step_id, :questions_attributes

  validates :name, presence: true
  validates :material, presence: true

  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |q| q[:text].blank? }, :allow_destroy => true

  belongs_to :step

  has_many :introns, dependent: :destroy
  accepts_nested_attributes_for :introns, :allow_destroy => true

end
