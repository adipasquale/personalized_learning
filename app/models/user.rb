class User < ActiveRecord::Base
  attr_accessible :is_admin, :login, :step_id, :material_type, :user_traits_attributes, :answers_attributes

  before_save :create_remember_token

  has_many :user_traits, dependent: :destroy

  validates :login, presence: true, uniqueness: true

  accepts_nested_attributes_for :user_traits

  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, :allow_destroy => true

  scope :students, where(is_admin: [false, nil])

  belongs_to :step

  validates_inclusion_of :material_type, :in => %w(personalized traditional)

  def current_tasks
    Task.where(step_id: step_id)
  end

  def current_questionnaires
    Questionnaire.where(step_id: step_id)
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
