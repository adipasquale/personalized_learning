class Intron < ActiveRecord::Base
  attr_accessible :slug, :task_id, :trait_id, :variations_attributes

  belongs_to :trait
  belongs_to :task

  validates :slug, presence: true
#  validates :trait_id, presence: true

  has_many :variations, dependent: :destroy
  accepts_nested_attributes_for :variations
  validate :matching_variations



  def get_personalized_value_for_user user
    user_trait = user.user_traits.select{ |ut| ut.trait_id == trait_id }
    val = nil
    if !user_trait.nil?
      if trait.options.any?
        user_option = user_trait.first.option
        val = variations.where(option_id: user_option.id).first.content
      else
        val = user_trait.first.value
      end
    end
    return val
  end

  private

    def matching_variations
      if trait.options.empty? and !variations.empty?
        errors.add(:variations, "there should be no variations, since trait has no options")
      else

      end
    end

end
