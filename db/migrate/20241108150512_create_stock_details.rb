class CreateStockDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :stock_details do |t|
      t.string :symbol
      t.string :identifier
      t.float :open
      t.float :day_high
      t.float :day_low
      t.float :last_price
      t.float :previous_close
      t.float :change
      t.float :p_change
      t.float :year_high
      t.float :year_low
      t.float :total_traded_value
      t.float :total_traded_volume
      t.datetime :last_update_time
      t.float :per_change_30d
      t.float :per_change_365d
      t.belongs_to :stock

      t.timestamps
    end
  end
end
