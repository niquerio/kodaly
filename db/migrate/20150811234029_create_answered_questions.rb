class CreateAnsweredQuestions < ActiveRecord::Migration
  def change
    create_table :answered_questions do |t|
      t.references :question
      t.references :choice
      t.references :user
      t.timestamps null: false
    end
  end
end
