# frozen_string_literal: true

# Create Account
class DeviseTokenAuthCreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table(:accounts) do |t|
      ## Required
      t.string :provider, null: false, default: 'email'
      t.string :uid, null: false, default: ''

      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, default: false

      ## Rememberable
      t.datetime :remember_created_at

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## User Info
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.float :amount, default: 0
      t.integer :status, null: false, default: 0

      ## Tokens
      t.json :tokens

      t.timestamps
    end

    add_index :accounts, :email, unique: true
    add_index :accounts, %i[uid provider], unique: true
    add_index :accounts, :reset_password_token, unique: true
    add_index :accounts, :status
    add_index :accounts, :phone_number
    # add_index :account, :confirmation_token,   unique: true
    # add_index :account, :unlock_token,         unique: true
  end
end
