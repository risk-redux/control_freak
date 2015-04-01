class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.string :number
      t.text :description
      t.boolean :is_odv

      t.timestamps null: false
    end
  end
end
