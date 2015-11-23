class RemoveNumberFromSupplements < ActiveRecord::Migration
  def change
	  remove_column :supplements, :number
  end
end
