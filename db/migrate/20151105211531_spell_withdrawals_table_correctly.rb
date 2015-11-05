class SpellWithdrawalsTableCorrectly < ActiveRecord::Migration
  def change
    rename_table :withdrawls, :withdrawals
  end
end
