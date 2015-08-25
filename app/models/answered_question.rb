class AnsweredQuestion < ActiveRecord::Base
    belongs_to :question
    belongs_to :choice
    belongs_to :user

    def is_choice_correct
      return self.choice === self.question.correct_choice
    end
end
