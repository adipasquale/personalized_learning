class AddLabelToChoice < ActiveRecord::Migration
  def change
    add_column :choices, :label, :string
  end
end
