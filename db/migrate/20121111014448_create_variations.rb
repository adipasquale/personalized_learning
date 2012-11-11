class CreateVariations < ActiveRecord::Migration
  def change
    create_table :variations do |t|
      t.string :content
      t.integer :intron_id
      t.integer :option_id

      t.timestamps
    end
  end
end
