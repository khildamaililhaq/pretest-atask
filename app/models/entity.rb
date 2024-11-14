class Entity < ApplicationRecord
  before_create :encrypt_password
  before_update :encrypt_password
  before_create :encrypt_pin
  before_update :encrypt_pin
  has_many :entity_tokens
  has_many :debits, as: :debitable, class_name: "WalletTransaction"
  has_many :credits, as: :creditable, class_name: "WalletTransaction"

  attribute :password
  attribute :pin

  validates :pin, format: { with: /\A\d+\Z/ }, length: { is: 6 }, allow_nil: true

  validates_presence_of :name, :username, :password, on: :create
  validates_uniqueness_of :username

  def authenticate(password)
    crypt(password) == self.password_digest
  end

  def authenticate_pin(pin)
    crypt(pin) == self.pin_digest
  end

  def generate_token
    token = SecureRandom.hex(10)
    EntityToken.create(entity: self, token:, expired_at: 1.day.from_now)
  end

  def update_balance!
    update(balance: debits.sum(:amount) - credits.sum(:amount))
  end

  handle_asynchronously :update_balance!

  def wallet_transactions
    WalletTransaction.where("debitable_id = ? OR creditable_id = ?", id, id)
  end

  def current_balance
    debits.sum(:amount) - credits.sum(:amount)
  rescue StandardError
    0
  end

  def transfer(params)
    is_balance_valid? params[:amount]

    @destination_entity = Entity.find(params[:entity_id])

    transaction = WalletTransaction.new wallet_hash(params)
    transaction.creditable = self
    transaction.debitable = @destination_entity
    raise StandardError, "Failed to transfer" unless transaction.save
    transaction.update_balance

    transaction
  end

  def deposit(params)
    transaction = WalletTransaction.new wallet_hash(params)
    transaction.debitable = self
    raise StandardError, "Failed to Deposit" unless transaction.save
    transaction.update_balance

    transaction
  end

  def withdraw(params)
    is_balance_valid? params[:amount]

    transaction = WalletTransaction.new wallet_hash(params)
    transaction.creditable = self
    raise StandardError, "Failed to Withdraw, Insufficient Fund" unless transaction.save
    transaction.update_withdrawal

    transaction
  end

  private
  def crypt(password)
    Digest::MD5.hexdigest(password)
  end

  def encrypt_password
    return unless password.present?

    self.password_digest = crypt password
  end

  def encrypt_pin
    return unless pin.present?

    self.pin_digest = crypt pin
  end

  def wallet_hash(params)
    {
      amount: params[:amount],
      transaction_date: Date.today
    }
  end

  def is_balance_valid?(amount)
    raise StandardError, "Failed To Transfer, Insufficient Fund" if current_balance.to_i < amount.to_f
  end
end
