class WalletTransaction < ApplicationRecord
  after_create :assign_number
  belongs_to :creditable, polymorphic: true, optional: true
  belongs_to :debitable, polymorphic: true, optional: true

  def assign_number
    self.number = "T#{id.to_s.rjust(6, '0')}"
    save
  end

  def update_balance
    debitable.update_balance! if creditable.present?
    creditable.update_balance! if creditable.present?
  end

  def update_withdrawal
    creditable.update_balance! if creditable.present?
  end
end
