class Variation < ActiveRecord::Base
  attr_accessible :content, :exon_id, :option_id

  belongs_to :exon
  belongs_to :option

  def get_content
    content.blank? ? option.value : content
  end
end
