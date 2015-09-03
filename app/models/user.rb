class User < ActiveRecord::Base
  has_many :answered_questions
  #has_many :question_factories #is this right? I don't think so

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def is_quiz_complete(question_factory)
    #Should it be complete only in one session? Right now it doesn't care about sessions.
    streak = 0    
    AnsweredQuestion.where(user: self).where(question_factory: question_factory).each do |aq|
        if aq.choice.correct
          streak += 1  
          if streak == 10
            return true
          end
        else
          streak = 0 
        end
    end
    return false
  end

  def get_highest_streak(question_factory)
    highest_streak = 0
    current_streak = 0
    AnsweredQuestion.where(user: self).where(question_factory: question_factory).each do |aq|
        if aq.choice.correct
          current_streak += 1  
          highest_streak = current_streak if current_streak > highest_streak
        else
          current_streak = 0 
        end
    end
    return highest_streak
  end

  def get_current_streak(question_factory)
    streak = 0
    AnsweredQuestion.where(user: self).where(question_factory: question_factory).order(created_at: :desc).each do |aq|
      if aq.choice.correct
        streak += 1
      else
        return streak
      end
    end
    return streak
  end

end
