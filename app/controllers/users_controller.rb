class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @question_factories =  Array.new
    QuestionFactory.find_each do |qf|
      @question_factories << {
        id: qf.id,
        name: qf.name,
        complete: @user.is_quiz_complete(qf),
        highest_streak: @user.get_highest_streak(qf),
        current_streak: @user.get_current_streak(qf)
      }
    end
  end
end
