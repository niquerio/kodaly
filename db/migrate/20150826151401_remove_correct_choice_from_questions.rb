class RemoveCorrectChoiceFromQuestions < ActiveRecord::Migration
  def change
    remove_reference :questions, :correct_choice, index: true
    remove_foreign_key :questions, :correct_choices
  end
end
