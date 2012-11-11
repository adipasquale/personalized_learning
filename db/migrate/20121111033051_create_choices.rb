class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.integer :question_id
      t.boolean :right
      t.string :text

      t.timestamps
    end
  end
end
