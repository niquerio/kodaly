class CreateQuestionFactories < ActiveRecord::Migration
  def change
    create_table :question_factories do |t|
      t.string :url

      t.timestamps null: false
    end
  end
end
