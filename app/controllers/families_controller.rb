ActiveRecord::Base.include_root_in_json = true

class FamiliesController < ApplicationController
  # See also the cache settings on the `control` controller.
  caches_page :index, :show

  def index
    @families = Family.all
    @family_count = @families.size

    @control_count = Control.group(:family).count

    respond_to do |format|
      format.html {}
      format.json { render json: @families.as_json(except: [:created_at, :updated_at]) }
    end
  end

  def show
    @family = Family.where(acronym: params[:acronym].downcase).first
    @controls = @family.controls.order(:sort_number)

    respond_to do |format|
      format.html {}
      format.json {
        render json: @family.as_json(except: [:created_at, :updated_at],
        include: [
          controls: { except: [:created_at, :updated_at] }
        ])
      }
    end
  end
end
