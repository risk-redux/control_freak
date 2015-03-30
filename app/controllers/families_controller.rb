class FamiliesController < ApplicationController
  def index
    @families = Family.all
    @family_count = @families.size

    @control_count = Control.group(:family).count
    puts @control_count, "\n\n\n\n\n\n\n\n\n"
  end

  def show
    @family = Family.find(params[:id])
    @controls = Controls.where(family: @family.name)
  end
end
