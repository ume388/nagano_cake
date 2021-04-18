class ChangeShippnigCostOfOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :shipping_cost, :integer, default: 800
  end
  
  def down
    change_column :orders, :shipping_cost, :integer
  end
end
