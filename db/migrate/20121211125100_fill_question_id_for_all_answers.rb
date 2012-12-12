class FillQuestionIdForAllAnswers < ActiveRecord::Migration
  def up
    Answer.all.each do |answer|
      if answer.question_id.nil?
        answer.update_attributes(question_id: answer.choice.question_id)
      end
    end
  end
end
