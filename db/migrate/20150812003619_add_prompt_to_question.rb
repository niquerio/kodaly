class AddPromptToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :prompt, :string
  end
end
