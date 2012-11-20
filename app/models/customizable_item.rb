class CustomizableItem < ActiveRecord::Base
  self.abstract_class = true
  attr_accessible :introns_attributes

  validate :matching_introns

  def personalize_content_for_user user
    introns.each do |intron|
      val = intron.get_content_for_user user
      personalizable_content.gsub!(/\$#{intron.slug}\$/, val) unless val.nil?
    end
    personalizable_content
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