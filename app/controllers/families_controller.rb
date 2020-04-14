ActiveRecord::Base.include_root_in_json = true

class FamiliesController < ApplicationController
  def index
    @families = Family.all
    @family_count = @families.size

    @control_count = Control.group(:family_name).count

    respond_to do |format|
      format.html {}
      format.json { render json: @families.as_json(except: [:id, :created_at, :updated_at]) }
    end
  end

  def show
    @family = Family.where(acronym: params[:acronym].downcase).first
    @controls = @family.controls.all

    respond_to do |format|
      format.html {}
      format.json {
        render json: @family.as_json(except: [:id, :created_at, :updated_at],
        include: [
          controls: { except: [:id, :family_id, :created_at, :updated_at] }
        ])
      }
    end
  end
end
