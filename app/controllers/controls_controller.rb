ActiveRecord::Base.include_root_in_json = true

class ControlsController < ApplicationController
  def index
    @controls = Control.where(parent_id: nil).order(:sort_number)

    respond_to do |format|
      format.html {}
      format.json { render json: JSON.pretty_generate(@controls.as_json(except: [:created_at, :updated_at])) }
    end
  end

  def show
    search = params[:label]

    @control = Control.where(number: search.downcase).or(Control.where(sort_number: search.downcase)).or(Control.where(label: search)).first

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
