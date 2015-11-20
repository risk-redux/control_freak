class AddControlIdToReferences < ActiveRecord::Migration
  def change
    add_column :references, :control_id, :integer
  end
end
