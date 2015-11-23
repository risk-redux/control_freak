class AddControlIdColumnToWithdrawals < ActiveRecord::Migration
  def change
    add_column :withdrawals, :control_id, :integer
  end
end
