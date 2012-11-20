class Variation < ActiveRecord::Base
  attr_accessible :content, :intron_id, :option_id

  belongs_to :intron
  belongs_to :option

  def get_content
    content.blank? ? option.value : content
  end
end
