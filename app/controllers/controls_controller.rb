class ControlsController < ApplicationController

	def index
		@controls = Control.where(is_enhancement: false)
	end

	def show
		@control = Control.where(number: params[:number]).first

		@statements = @control.statements
		@references = @control.references
		@supplement = @control.supplement
		@related_controls = !@supplement.nil? ? @supplement.related.split(",") : []

		@enhancements = @control.children
		@enhancement_supplements = {}
		@enhancement_statements = {}

		@enhancements.each do |enhancement|
			@enhancement_supplements[enhancement.number] = enhancement.supplement
			@enhancement_statements[enhancement.number] = enhancement.statements
		end
	end

end
