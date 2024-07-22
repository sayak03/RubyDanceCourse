class ChangeIntegerLimitInTable < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :contact_number, :integer, limit: 8
  end
end
