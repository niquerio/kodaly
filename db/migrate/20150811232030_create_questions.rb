class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|

      t.references :correct_choice, index: true
      t.timestamps null: false
    end
  end
end
