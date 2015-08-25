class ChangeQuestionFactoryColumnName < ActiveRecord::Migration
  def change
    rename_column :question_factories, :url, :name
  end
end
