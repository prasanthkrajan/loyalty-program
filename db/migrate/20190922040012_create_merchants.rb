class CreateMerchants < ActiveRecord::Migration[5.2]
  def change
    create_table :merchants do |t|
      t.string :full_name
      t.string :nature_of_business

      t.timestamps
    end
  end
end
