class Task < ActiveRecord::Base
  attr_accessible :material, :name, :step_id, :introns_attributes, :questions_attributes

  validates :name, presence: true
  validates :material, presence: true

  has_many :introns, dependent: :destroy
  accepts_nested_attributes_for :introns, :allow_destroy => true

  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |q| q[:text].blank? }, :allow_destroy => true

  validate :matching_introns

  belongs_to :step

  def personalize_material_for_user user
    introns.each do |intron|
      val = intron.get_content_for_user user
      material.gsub!(/\$#{intron.slug}\$/, val) unless val.nil?
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
