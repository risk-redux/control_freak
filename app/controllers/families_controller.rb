ActiveRecord::Base.include_root_in_json = true

class FamiliesController < ApplicationController
  def index
    @families = Family.all
    @family_count = @families.size

    @control_count = Control.group(:family).count

    respond_to do |format|
      format.html {}
      format.json { render json: JSON.pretty_generate(@families.as_json(except: [:created_at, :updated_at])) }
    end
  end

  def show
    @family = Family.where(acronym: params[:acronym].downcase).first
    @controls = @family.controls.order(:sort_number)

    respond_to do |format|
      format.html {}
      format.json {
        render json: JSON.pretty_generate(@family.as_json(except: [:created_at, :updated_at],
        include: [
          controls: { except: [:created_at, :updated_at] }
        ]))
      }
    end
  end
end
