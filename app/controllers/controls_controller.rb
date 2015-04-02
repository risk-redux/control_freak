class ControlsController < ApplicationController
  def index
    @controls = Control.where(is_enhancement: false)
  end

  def show
    @control = Control.where(number: params[:number]).first
  end
end
