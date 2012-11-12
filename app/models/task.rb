class Task < ActiveRecord::Base
  attr_accessible :material, :name, :introns_attributes, :questions_attributes

  validates :name, presence: true
  validates :material, presence: true

  has_many :introns, dependent: :destroy
  accepts_nested_attributes_for :introns, :allow_destroy => true

  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |o| o[:text].blank? }, :allow_destroy => true

  validate :matching_introns

  def personalize_material user
    introns.each do |intron|
      val = user.user_traits.select{ |ut| ut.trait_id == intron.trait.id }.first.get_value
      material.gsub!(/\$#{intron.slug}\$/, val)
    end
  end

  private

    def matching_introns
      # re = /\$([a-z_]{1,20})\$/g
      # res = re.match material
      # res.each do |slug|
      #   if slug not in introns_attributes.pluck :slug
      #     errors.add(:material, "introns don't match material")
      #     break
      #   end
      # end
    end
end
