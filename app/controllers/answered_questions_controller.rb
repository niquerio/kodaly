class AnsweredQuestionsController < ApplicationController
    def create
       @answered_question = AnsweredQuestion.new(answeredQuestion_params)
       @correct = @answered_question.is_choice_correct;
       respond_to do |format|
           format.json 
       end
    end

     private

       def answeredQuestion_params
               params.require(:answered_question).permit(:choice_id, :question_id)
       end
     end
