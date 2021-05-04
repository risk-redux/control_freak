ActiveRecord::Base.include_root_in_json = true

class ControlsController < ApplicationController
  # This is one big ugly page, and I ought to think of an elegant cache expiration solution for it... Maybe something with sweepers that monitor changes to `Control`?
  caches_page :index

  def index
    @controls = Control.order(:sort_number)

    respond_to do |format|
      format.html {}
      format.json { render json: JSON.pretty_generate(@controls.as_json(except: [:created_at, :updated_at])) }
    end
  end

  def show
    @control = Control.where(label: params[:label]).first

    respond_to do |format|
      format.html {}
      format.json {
        render json: JSON.pretty_generate(@control.as_json(except: [:created_at, :updated_at], include: [
          parameters: { except: [:created_at, :updated_at] },
          parts: { except: [:created_at, :updated_at] },
          links: { except: [:created_at, :updated_at] },
          children: { except: [:created_at, :updated_at] }
        ]))
      }
    end
  end
end
