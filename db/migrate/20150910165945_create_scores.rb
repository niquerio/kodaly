class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.boolean :complete
      t.integer :current_streak
      t.integer :highest_streak
      t.references :question_factory, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :scores, :question_factories
    add_foreign_key :scores, :users
  end
end
