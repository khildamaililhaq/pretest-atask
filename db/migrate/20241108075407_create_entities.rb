class CreateEntities < ActiveRecord::Migration[7.2]
  def change
    create_table :entities do |t|
      t.string :name
      t.string :type, index: true
      t.belongs_to :parent
      t.string :password_digest
      t.string :username, index: { unique: true }
      t.timestamps
    end
  end
end
