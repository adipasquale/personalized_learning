class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :task_id
      t.string :text

      t.timestamps
    end
  end
end
