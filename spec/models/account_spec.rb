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
require 'rails_helper'

RSpec.describe Account, type: :model do
  subject(:account) { build(:account) }

  it 'has a valid factory' do
    expect(account).to be_valid
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:phone_number) }
    it { is_expected.to validate_presence_of(:email) }
  end
end
