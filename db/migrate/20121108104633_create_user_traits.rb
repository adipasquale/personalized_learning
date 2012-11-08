class CreateUserTraits < ActiveRecord::Migration
  def change
    create_table :user_traits do |t|
      t.integer :user_id
      t.string :value
      t.integer :trait_id
      t.integer :option_id

      t.timestamps
    end
  end
end
