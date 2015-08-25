class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :midi_blob
      t.belongs_to :question, index:true

      t.timestamps null: false
    end
  end
end
