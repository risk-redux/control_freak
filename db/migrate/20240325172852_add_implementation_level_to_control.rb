class AddImplementationLevelToControl < ActiveRecord::Migration[7.1]
  def change
    add_column :controls, :implementation_level, :string
  end
end
