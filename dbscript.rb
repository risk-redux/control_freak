fams = Family.all

fams.each do |fam|

	ctrls = Control.where("family = '#{fam.name}'")

	ctrls.each do |ctrl|
		puts "#{fam.id}: #{ctrl.family}"
		ctrl.update({family_id: fam.id})
	end

end