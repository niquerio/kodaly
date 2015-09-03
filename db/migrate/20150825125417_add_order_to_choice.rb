class AddOrderToChoice < ActiveRecord::Migration
  def change
    add_column :choices, :order, :integer
  end
end
