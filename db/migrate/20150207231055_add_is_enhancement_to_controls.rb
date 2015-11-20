class AddIsEnhancementToControls < ActiveRecord::Migration
  def change
    add_column :controls, :is_enhancement, :boolean
  end
end
