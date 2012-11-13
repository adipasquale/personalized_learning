class Answer < ActiveRecord::Base
  attr_accessible :choice_id, :user_id, :question_id, :text

  belongs_to :choice
  belongs_to :user
  belongs_to :question

  def keep_or_create
    !new_record?
  end
end
