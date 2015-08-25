class QuestionsController < ApplicationController
    def show
        @question = Question.find(params[:id])
        @choices = @question.choices
    end 
end
