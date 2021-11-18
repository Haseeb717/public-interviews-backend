# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  amount                 :float            default(0.0)
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  phone_number           :string
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  status                 :integer          default("pending"), not null
#  tokens                 :json
#  uid                    :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_accounts_on_email                 (email) UNIQUE
#  index_accounts_on_phone_number          (phone_number)
#  index_accounts_on_reset_password_token  (reset_password_token) UNIQUE
#  index_accounts_on_status                (status)
#  index_accounts_on_uid_and_provider      (uid,provider) UNIQUE
#
class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend Devise::Models
  devise authentication_keys: [:email, :phone_number]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :first_name, :last_name, :email, :phone_number, presence: true
  has_many :histories

  enum status: {
    unverified: -1,
    pending: 0,
    verified: 1
  }, _suffix: true

  def add_balance(balance)
    total_amount = amount+balance.to_i
    self.update(amount: total_amount)
    History.deposit(self,balance.to_i)
  end

  def decreament_balance(balance)
    total_amount = amount-balance.to_i
    self.update(amount: total_amount)
    History.withdraw(self,balance.to_i)
  end

  def low_amount?(balance)
    amount < balance.to_i
  end
end
