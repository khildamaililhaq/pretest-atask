class Entity < ApplicationRecord
  before_create :encrypt_password
  before_update :encrypt_password
  has_many :entity_tokens

  attribute :password

  validates_presence_of :name, :username, :password, on: :create
  validates_uniqueness_of :username

  def authenticate(password)
    crypt(password) == self.password_digest
  end

  def generate_token
    token = SecureRandom.hex(10)
    EntityToken.create(entity: self, token:, expired_at: 1.day.from_now)
  end

  private
  def crypt(password)
    Digest::MD5.hexdigest(password)
  end

  def encrypt_password
    return unless password.present?

    self.password_digest = crypt password
  end
end
