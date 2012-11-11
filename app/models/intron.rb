class Intron < ActiveRecord::Base
  attr_accessible :slug, :task_id, :trait_id, :variations_attributes

  belongs_to :trait
  belongs_to :task

  validates :slug, presence: true
#  validates :trait_id, presence: true

  has_many :variations, dependent: :destroy
  accepts_nested_attributes_for :variations
  validate :matching_variations

  private

    def matching_variations
      if trait.options.empty? and !variations.empty?
        errors.add(:variations, "there should be no variations, since trait has no options")
      else

      end
    end

end
