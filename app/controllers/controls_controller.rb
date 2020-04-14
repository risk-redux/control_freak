ActiveRecord::Base.include_root_in_json = true

class ControlsController < ApplicationController
  # This is one big ugly page, and I ought to think of an elegant cache expiration solution for it... Maybe something with sweepers that monitor changes to `Control`?
  caches_page :index

  def index
    @controls = Control.order(:sort_number)

    respond_to do |format|
      format.html {}
      #format.json { render json: @controls.as_json(except: [:id, :created_at, :updated_at]) }
    end
  end

  def show
    @control = Control.where(sort_number: params[:sort_number]).first

    respond_to do |format|
      format.html {}
      # format.json {
      #   render json: @control.as_json(except: [:id, :parent_id, :family_id, :created_at, :updated_at], include: [
      #     statements: { except: [:id, :control_id, :created_at, :updated_at] },
      #     references: { except: [:id, :control_id, :created_at, :updated_at] },
      #     supplement: { except: [:id, :control_id, :created_at, :updated_at] },
      #     children: { except: [:id, :parent_id, :family_id, :control_id, :created_at, :updated_at] }
      #   ])
      # }
    end
  end
end
