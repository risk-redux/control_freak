class AddControlIdToSupplements < ActiveRecord::Migration
  def change
	  add_column :supplements, :control_id, :integer
  end
end
