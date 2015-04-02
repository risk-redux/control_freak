class ControlsController < ApplicationController
  def index
    @controls = Control.where(is_enhancement: false)
  end

  def show
    @control = Control.where(number: params[:number]).first

    # This is an ugly hack for MySQL and the way NIST numbers their statements.
    @statements = Statement.where("number REGEXP ?", "#{params[:number]}([a-z]|$)")
    @references = Reference.where(number: params[:number])
  end
end
