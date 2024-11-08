class CreateEntityTokens < ActiveRecord::Migration[7.2]
  def change
    create_table :entity_tokens do |t|
      t.string :token
      t.datetime :expired_at
      t.belongs_to :entity

      t.timestamps
    end
  end
end
