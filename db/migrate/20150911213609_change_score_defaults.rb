class ChangeScoreDefaults < ActiveRecord::Migration
  def change
    change_column_default :scores, :complete, false
    change_column_default :scores, :highest_streak, 0
    change_column_default :scores, :current_streak, 0
  end
end
