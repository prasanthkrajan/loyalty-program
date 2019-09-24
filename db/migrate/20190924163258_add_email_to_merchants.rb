class AddEmailToMerchants < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :email, :string
  end
end
