class ControlsController < ApplicationController
  def index
    @controls = Control.all
  end
end
