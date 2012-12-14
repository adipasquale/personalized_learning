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

  def current_tasks(options={})
    tasks = Task.where(step_id: step_id, is_finalized: true)
    current_objects(tasks, options)
  end

  def current_questionnaires(options={})
    questionnaires = Questionnaire.where(step_id: step_id)
    current_objects(questionnaires, options)
  end

  def next_step
    Step.where("sequence_order > ?", step.sequence_order).first
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    # objects are Tasks or Questionnaires
    def current_objects(objects, options={})
      if !options[:all]
        objects.reject! do |object|
          questions_count = object.questions.count
          answers_count = object.questions.map { |question|
            question.answers.where(user_id: self.id).count
          }.sum
          puts "reject ? #{questions_count == answers_count}"
          questions_count == answers_count
        end
      end
      objects
    end

end
