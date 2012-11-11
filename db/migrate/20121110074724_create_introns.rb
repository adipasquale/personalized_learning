class CreateIntrons < ActiveRecord::Migration
  def change
    create_table :introns do |t|
      t.string :slug
      t.integer :trait_id
      t.integer :task_id

      t.timestamps
    end
  end
end
