class CreateWalletTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :wallet_transactions do |t|
      t.references :creditable, polymorphic: true
      t.references :debitable, polymorphic: true
      t.integer :amount, null: false
      t.date :transaction_date, null: false, index: true

      t.integer :created_by, index: true
      t.integer :updated_by, index: true
      t.string :number, index: { unique: true }

      t.timestamps
    end
  end
end
