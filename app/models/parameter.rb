class Parameter < ApplicationRecord
	belongs_to :ctrl, class_name: "Control", foreign_key: "control_id"
end