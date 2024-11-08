class EntityToken < ApplicationRecord
  belongs_to :entity

  scope :active, -> { where("expired_at > ?", DateTime.now) }
end
