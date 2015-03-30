class FamiliesController < ApplicationController
  def index
    @families = Family.all
    @family_count = @families.size
  end

  def show
    @family = Family.find(params[:id])
    @controls = Controls.where(family: @family.name)
  end
end
