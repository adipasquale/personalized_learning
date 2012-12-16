class Exon < ActiveRecord::Base
  attr_accessible :slug, :traditional_content, :task_id, :trait_id, :variations_attributes

  belongs_to :trait

  # one of these three, should have a table for CustomizableItem instead
  belongs_to :task
  belongs_to :question
  belongs_to :choice

  validates :slug, presence: true
  validates :traditional_content, presence: true
#  validates :trait_id, presence: true

  has_many :variations, dependent: :destroy
  accepts_nested_attributes_for :variations
  validate :matching_variations

  def get_content_for_user user
    if user.material_type == "personalized"
      user_trait = user.user_traits.select{ |ut| ut.trait_id == trait_id }
      content = nil
      if !user_trait.empty?
        if trait.options.any?
          user_option = user_trait.first.option
          content = variations.where(option_id: user_option.id).first.get_content
        else
          content = user_trait.first.value
        end
      end
    else
      content = traditional_content
    end
    return content
  end

  private

    def matching_variations
      if trait.options.empty? and !variations.empty?
        errors.add(:variations, "there should be no variations, since trait has no options")
      else

      end
    end

end
