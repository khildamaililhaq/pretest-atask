class WalletDepositSerializer < ActiveModel::Serializer
  attributes :id, :amount, :current_balance, :balance_before, :created_at, :updated_at, :number

  def current_balance
    debitable.try(:current_balance)
  end

  def balance_before
    debitable.try(:current_balance) - object.amount
  end

  private

  def debitable
    object.try(:debitable)
  end
end
