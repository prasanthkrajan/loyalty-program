class CreatePointsLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :points_logs do |t|
      t.integer :points_earned
      t.references :user, foreign_key: true
      t.date :valid_until

      t.timestamps
    end
  end
end
