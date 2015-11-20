class RemoveNumberFromReferences < ActiveRecord::Migration
  def change
	  remove_column :references, :number
  end
end
