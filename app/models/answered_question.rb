class AnsweredQuestion < ActiveRecord::Base
  belongs_to :question_factory
  belongs_to :choice
  belongs_to :user
  

  def is_choice_correct
    return self.choice.correct
  end
end
