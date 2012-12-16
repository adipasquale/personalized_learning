class CustomizableItem < ActiveRecord::Base
  self.abstract_class = true
  attr_accessible :exons_attributes

  validate :matching_exons

  def personalize_content_for_user user
    exons.each do |exon|
      val = exon.get_content_for_user user
      personalizable_content.gsub!(/\$#{exon.slug}\$/, val) unless val.nil?
    end
    personalizable_content
  end

  private

    def matching_exons
      # re = /\$([a-z_]{1,20})\$/g
      # res = re.match material
      # res.each do |slug|
      #   if slug not in exons_attributes.pluck :slug
      #     errors.add(:material, "exons don't match material")
      #     break
      #   end
      # end
    end

end