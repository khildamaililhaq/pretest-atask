class AddPinDigestToEntities < ActiveRecord::Migration[7.2]
  def change
    add_column :entities, :pin_digest, :string
  end
end
