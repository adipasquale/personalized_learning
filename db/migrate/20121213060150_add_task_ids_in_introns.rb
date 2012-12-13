class AddTaskIdsInIntrons < ActiveRecord::Migration
  def up
    Intron.all.each do |i|
      if i.task_id.nil?
        task_id = i.question.task_id if !i.question.nil?
        task_id = i.choice.question.task_id if !i.choice.nil?
        i.update_attributes(task_id: task_id)
      end
    end
  end

  def down
    Intron.all.each do |i|
      if !i.task_id.nil? and (!i.question_id.nil? or !i.choice_id.nil?)
        i.update_attributes(task_id: nil)
      end
    end
  end
end
