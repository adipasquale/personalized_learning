class Choice < ActiveRecord::Base
  attr_accessible :question_id, :right, :text

  belongs_to :question
end
