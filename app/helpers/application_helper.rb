#encoding: utf-8

module ApplicationHelper

  def build_questions object, questions_count, choices_count
    (questions_count - object.questions.count).times do
      object.questions.build
    end
    object.questions.each do |question|
      (choices_count - question.choices.count).times { question.choices.build }
    end
  end

  def build_answers object, user
    @answers = {} # this object is useful to keep answers order in sync with choices order
    object.questions.each do |question|
      @answers[question.id] = []
      if question.choices.empty?
        saved_answers = user.answers.select{ |a| a.question_id == question.id}
        if saved_answers.empty?
          @answers[question.id].push user.answers.build question_id: question.id
        else
          @answers[question.id].push saved_answers.first
        end
      else
        question.choices.each do |choice|
          saved_answers = user.answers.select{ |a| a.choice_id == choice.id}
          if saved_answers.empty?
            @answers[question.id].push user.answers.build choice_id: choice.id
          else
            @answers[question.id].push saved_answers.first
          end
        end
        user.answers.reorder(:choice_id)
      end
    end
  end

end
