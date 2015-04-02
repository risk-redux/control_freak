class ChangeSupplementsReferenceToText < ActiveRecord::Migration
  def change
    change_column :supplements, :related, :text
  end
end
