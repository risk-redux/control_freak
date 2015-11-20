class ChangeStatementsControlNumberToControlId < ActiveRecord::Migration
  def change
	  rename_column :statements, :control_number, :control_id
  end
end
