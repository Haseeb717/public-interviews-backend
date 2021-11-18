class CreateHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :histories do |t|
      t.references :account, null: false, foreign_key: true
      t.float :amount
      t.integer :action

      t.timestamps
    end
  end
end
