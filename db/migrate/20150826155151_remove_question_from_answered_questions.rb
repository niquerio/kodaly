class RemoveQuestionFromAnsweredQuestions < ActiveRecord::Migration
  def change
    remove_reference :answered_questions, :question, index: true
    remove_foreign_key :answered_questions, :questions
  end
end
