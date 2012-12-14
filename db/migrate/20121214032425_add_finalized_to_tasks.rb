class AddFinalizedToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :is_finalized, :boolean
  end
end
