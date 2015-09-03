class AddQuestionFactoryRefToQuestion < ActiveRecord::Migration
  def change
    add_reference :questions, :question_factory, index: true
    add_foreign_key :questions, :question_factories
  end
end
