class CreateControls < ActiveRecord::Migration
  def change
    create_table :controls do |t|
      t.text :family
      t.text :number
      t.text :title
      t.text :priority
      t.boolean :is_baseline_impact_low
      t.boolean :is_baseline_impact_moderate
      t.boolean :is_baseline_impact_high
      t.boolean :is_withdrawn

      t.timestamps null: false
    end
  end
end
