class ChangeFamilyToFamilyNameInControls < ActiveRecord::Migration
  def change
	  rename_column :controls, :family, :family_name
  end
end
