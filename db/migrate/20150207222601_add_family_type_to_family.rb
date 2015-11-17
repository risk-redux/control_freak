class AddFamilyTypeToFamily < ActiveRecord::Migration
  def change
    add_column :families, :family_type, :text
  end
end
