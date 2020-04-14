class Part < ApplicationRecord
  belongs_to :ctrl, foreign_key: 'control_id', class_name: 'Control', optional: true
  belongs_to :parent, class_name: 'Part', optional: true
  has_many :children, foreign_key: :parent_id, class_name: 'Part'
end