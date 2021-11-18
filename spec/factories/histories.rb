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
FactoryBot.define do
  factory :history do
    account { nil }
    amount { 1.5 }
    action { 1 }
  end
end
