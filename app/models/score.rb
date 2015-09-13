class Score < ActiveRecord::Base
  belongs_to :question_factory
  belongs_to :user

  def complete(options = {})
    if options[:reload]
     streak = 0    
     AnsweredQuestion.where(user: self.user).where(question_factory: self.question_factory).each do |aq|
         if aq.choice.correct
           streak += 1  
           if streak == 10
             write_attribute :complete, true
             break
           end
         else
           streak = 0 
           write_attribute :complete, false
         end
     end
    end
    read_attribute :complete
  end
end
