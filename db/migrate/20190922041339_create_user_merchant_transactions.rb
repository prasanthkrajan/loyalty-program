class CreateUserMerchantTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_merchant_transactions do |t|
      t.string :currency
      t.decimal :amount
      t.references :merchant, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
