class RemoveQuestionAndChoiceForeignKeysInIntrons < ActiveRecord::Migration
  def up
    remove_column :introns, :question_id
    remove_column :introns, :choice_id
  end

  def down
    add_column :introns, :question_id, :integer
    add_column :introns, :choice_id, :integer
  end

end
