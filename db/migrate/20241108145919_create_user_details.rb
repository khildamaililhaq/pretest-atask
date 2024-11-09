class CreateUserDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :user_details do |t|
      t.string :phone_number
      t.string :email
      t.date :birthdate
      t.string :birthplace
      t.text :address
      t.belongs_to :user

      t.timestamps
    end
  end
end
