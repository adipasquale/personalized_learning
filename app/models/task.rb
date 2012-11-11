class Task < ActiveRecord::Base
  attr_accessible :material, :name, :introns_attributes

  validates :name, presence: true
  validates :material, presence: true

  has_many :introns, dependent: :destroy

  accepts_nested_attributes_for :introns, :allow_destroy => true

  validate :matching_introns

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
