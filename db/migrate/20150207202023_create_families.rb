class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.text :name
      t.text :acronym

      t.timestamps null: false
    end
  end
end
