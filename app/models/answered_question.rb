class AnsweredQuestion < ActiveRecord::Base
  belongs_to :question_factory
  belongs_to :choice
  belongs_to :user
  
  after_save :update_score

  def is_choice_correct
    return self.choice.correct
  end

  def update_score
    score = Score.where(question_factory: self.question_factory, user: self.user).first_or_create

    if self.choice.correct
      score.increment!(:current_streak)
      if score.current_streak === 10 && !score.complete   
        score.update(complete: true)
      end
      if score.current_streak >= score.highest_streak
        score.update(highest_streak: score.current_streak)
      end 
    else
      score.update(current_streak: 0)
      new_score = Score.find_by(question_factory: self.question_factory, user: self.user)
    end 

  end

  
end
