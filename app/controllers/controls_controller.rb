class ControlsController < ApplicationController
  def index
    @controls = Control.where(is_enhancement: false)
  end

  def show
    @control = Control.where(number: params[:number]).first

    # These are ugly hacks for MySQL and the way NIST numbers their statements. Lots of ugh.
    @statements = Statement.where("number REGEXP ?", "#{params[:number]}([a-z]|$)")
    @references = Reference.where(number: params[:number])
    @supplement = Supplement.where("number REGEXP ?", "#{params[:number]}$").first
    @related_controls = @supplement.related.split(",")

    # More ugh, built out for enhancmenets, which are really just controls nested in controls.
    @enhancements = Control.where("is_enhancement = ? AND number REGEXP ?", true, "#{params[:number]} ")
    @enhancement_supplements = {}
    @enhancement_statements = {}
    @enhancements.each do |enhancement|
      @enhancement_supplements[enhancement.number] = Supplement.where(number: enhancement.number).first
      @enhancement_statements[enhancement.number] = Statement.where("number LIKE ?",  "#{enhancement.number}%")
    end
  end
end
