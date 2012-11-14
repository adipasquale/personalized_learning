class AddStepIdToUsersAndTasksAndQuestionnaires < ActiveRecord::Migration
  def change
    add_column :users, :step_id, :integer
    add_column :tasks, :step_id, :integer
  end
end
