class Answer < ActiveRecord::Base
  attr_accessible :choice_id, :user_id, :question_id, :text

  belongs_to :choice
  belongs_to :user
  belongs_to :question

  def keep_or_create
    !new_record?
  end


  def self.to_csv
    CSV.generate do |csv|
      csv << column_names + ["correct", "task_id", "task_name",
        "step_name", "step_order",
        "user_login", "material_type"]
      all.each do |answer|
        task = answer.question.task
        csv << answer.attributes.values_at(*column_names) +
          [answer.choice.right? ? 1 : 0, task.id, task.name,
            task.step.name, task.step.sequence_order,
            answer.user.login, answer.user.material_type ]
      end
    end
  end

end
