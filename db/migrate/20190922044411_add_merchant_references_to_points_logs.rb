class AddMerchantReferencesToPointsLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :points_logs, :issued_by, :integer, index: true
    add_foreign_key :points_logs, :merchants, column: :issued_by
  end
end
