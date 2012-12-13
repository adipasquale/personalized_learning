class RemoveQuestionAndChoicesNumbers < ActiveRecord::Migration
  def up
    Question.all.each do |q|
      q.update_attributes(text: q.text.strip.gsub(/^(Q[0-9]?\.)/, "").strip)
    end
    Choice.all.each do |c|
      c.update_attributes(text: c.text.strip.gsub(/^(\([A-Z]?\))/, "").strip)
    end
  end
end
