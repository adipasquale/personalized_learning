class AddMaterialTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :material_type, :string
  end
end
