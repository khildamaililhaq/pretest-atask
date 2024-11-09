class WalletTransferSerializer < ActiveModel::Serializer
  attributes :id, :destination_entity_name, :amount, :destination_entity_username,
             :current_balance, :created_at, :updated_at, :number

  def destination_entity_name
    debitable.try(:name)
  end

  def destination_entity_username
    debitable.try(:username)
  end

  def current_balance
    creditable.try(:current_balance)
  end

  private

  def debitable
    object.try(:debitable)
  end

  def creditable
    object.try(:creditable)
  end
end
