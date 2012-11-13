class AddTextAndQuestionIdToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :question_id, :integer
    add_column :answers, :text, :text
  end
end
