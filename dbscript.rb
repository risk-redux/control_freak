#stats = Statement.all

#stats.each do |stat|

#	if stat.number.index("(").nil?

#		ctrl = Control.where("number = '#{stat.number[/^([A-Z]{2}-[0-9]{1,2})/]}'").first
#		puts "CONTROL ID: #{ctrl.id}"
#	else
#		ctrl = Control.where("number = '#{stat.number[/^([A-Z]{2}-[0-9]{1,2}\s\([0-9]{1,2}\))/]}'").first
#	end

#	stat.update({control_id: ctrl.id})

# 	ctrls.each do |ctrl|
# 		puts "#{fam.id}: #{ctrl.family}"
# 		ctrl.update({family_id: fam.id})
# 	end

#end


#ctrls = Control.where(is_enhancement: false)

#ctrls.each do |parent_ctrl|

#	child_ctrls = Control.where("number LIKE ?",  "#{parent_ctrl.number} %")
#	child_ctrls.each do |child_ctrl|
#		child_ctrl.update({parent_id: parent_ctrl.id})
#	end

#end


#Supplement.all.each do |sppl|
#	sppl.update({control_id: Control.where(number: sppl.number).first.id})
#end

#Reference.all.each do |ref|
#	ref.update({control_id: Control.where(number: ref.number).first.id})
#end