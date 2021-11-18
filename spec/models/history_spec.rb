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
require 'rails_helper'

RSpec.describe History, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
