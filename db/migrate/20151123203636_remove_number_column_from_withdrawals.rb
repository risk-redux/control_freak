class RemoveNumberColumnFromWithdrawals < ActiveRecord::Migration
  def change
    remove_column :withdrawals, :number
  end
end
