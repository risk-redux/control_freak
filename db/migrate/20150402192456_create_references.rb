class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :number
      t.text :reference
      t.string :link

      t.timestamps null: false
    end
  end
end
