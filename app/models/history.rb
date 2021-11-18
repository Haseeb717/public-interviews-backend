# == Schema Information
#
# Table name: histories
#
#  id         :bigint           not null, primary key
#  action     :integer
#  amount     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#
# Indexes
#
#  index_histories_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class History < ApplicationRecord
  belongs_to :account

  enum action: {
    deposit: 0,
    withdraw: 1
  }, _suffix: true


  def self.deposit(account,balance)
    History.create(account_id: account.id,amount: balance,action: 0)
  end

  def self.withdraw(account,balance)
    History.create(account_id: account.id,amount: balance,action: 1)
  end
end
