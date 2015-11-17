class AddFamilyIdToControls < ActiveRecord::Migration
	def change
		add_column :controls, :family_id, :integer
	end
end
