class AddQuestionFactoryRefToAnsweredQuestion < ActiveRecord::Migration
  def change
    add_reference :answered_questions, :question_factory, index: true
    add_foreign_key :answered_questions, :question_factories
  end
end
