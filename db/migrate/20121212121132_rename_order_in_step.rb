class RenameOrderInStep < ActiveRecord::Migration
  def change
    change_table :steps do |t|
      t.rename :order, :sequence_order
    end
  end
end
