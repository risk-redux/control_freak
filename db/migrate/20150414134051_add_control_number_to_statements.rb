class AddControlNumberToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :control_number, :text
  end
end
