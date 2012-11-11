class Variation < ActiveRecord::Base
  attr_accessible :content, :intron_id, :option_id

  belongs_to :intron
  belongs_to :option

  validates :content, presence: true
end
