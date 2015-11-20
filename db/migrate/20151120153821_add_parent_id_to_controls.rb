class AddParentIdToControls < ActiveRecord::Migration
  def change
	  add_column :controls, :parent_id, :integer
  end
end
