class Withdrawal < ActiveRecord::Base
  # had to name this 'ctrl' because ActiveRecord already has a method called
  # "control" (therefore a reserved word for functions in active record)
	# feel free to change it to something else if you need the parent control of
  # a supplement!
	belongs_to :ctrl, class_name: "Control", foreign_key: "control_id"
end
