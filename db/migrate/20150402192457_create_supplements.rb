class CreateSupplements < ActiveRecord::Migration
  def change
    create_table :supplements do |t|
      t.string :number
      t.text :description
      t.string :related

      t.timestamps null: false
    end
  end
end
