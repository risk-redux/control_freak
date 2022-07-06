class CreateCatalogs < ActiveRecord::Migration[7.0]
  def change
    create_table :catalogs do |t|
      t.string :uuid
      t.text :title
      t.string :version
      t.string :oscal_version

      t.timestamps
    end
  end
end
