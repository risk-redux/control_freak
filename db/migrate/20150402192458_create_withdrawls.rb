class CreateWithdrawls < ActiveRecord::Migration
  def change
    create_table :withdrawls do |t|
      t.string :number
      t.string :incorporated_into

      t.timestamps null: false
    end
  end
end
