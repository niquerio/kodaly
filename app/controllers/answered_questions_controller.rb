class AnsweredQuestionsController < ApplicationController
    def create
       user = User.find(answeredQuestion_params[:user_id])
       choice = Choice.find(answeredQuestion_params[:choice_id])
       qf = choice.question.question_factory
       logger.debug "Choice is: #{choice.inspect}; qf is #{qf.inspect}"
       @answered_question = AnsweredQuestion.create(choice: choice, question_factory: qf, user: user)
       @correct = @answered_question.is_choice_correct;
       respond_to do |format|
           format.json 
       end
    end

     private

       def answeredQuestion_params
            params.require(:answered_question).permit(:choice_id, :user_id)
            
       end
     end
