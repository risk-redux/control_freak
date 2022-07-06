class ResourcesController < ApplicationController
  def index
    @resources = Reference.all
  end
end
