class AddLastUpdatedTimeStockDetail < ActiveRecord::Migration[7.2]
  def change
    add_column :stock_details, :last_updated_time, :datetime
  end
end
