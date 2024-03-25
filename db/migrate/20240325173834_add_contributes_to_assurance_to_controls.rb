class AddContributesToAssuranceToControls < ActiveRecord::Migration[7.1]
  def change
    add_column :controls, :contributes_to_assurance, :boolean
  end
end
