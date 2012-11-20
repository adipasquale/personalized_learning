class AddQuestionIdAndChoiceIdToIntrons < ActiveRecord::Migration
  def change
    add_column :introns, :question_id, :integer
    add_column :introns, :choice_id, :integer
  end
end
