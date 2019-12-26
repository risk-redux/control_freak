class FamiliesController < ApplicationController
  def index
    @families = Family.all
    @family_count = @families.size

    @control_count = Control.where(is_enhancement: false).group(:family_name).count

    respond_to do |format|
      format.html {}
      format.json { render json: @families }
    end
  end

  def show
    @family = Family.where(acronym: params[:acronym]).first
    @controls = @family.controls.all

    respond_to do |format|
      format.html {}
      format.json { render json: @controls }
    end
  end
end
