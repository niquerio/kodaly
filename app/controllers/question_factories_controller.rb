class QuestionFactoriesController < ApplicationController
    def show
        @factory = QuestionFactory.find(params[:id])
        @question = @factory.make_question
        @choices = @question.choices
        @choices = @choices.order(:order)
       respond_to do |format|
           format.json 
       end
    end
end
