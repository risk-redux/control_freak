ActiveRecord::Base.include_root_in_json = true

class ControlsController < ApplicationController
  def index
    @controls = Control.all

    respond_to do |format|
      format.html {}
      #format.json { render json: @controls.as_json(except: [:id, :created_at, :updated_at]) }
    end
  end

  def show
    @control = Control.where(sort_number: params[:sort_number]).first

  #   @statements = @control.statements.order(:id)
	# 	@references = @control.references
	# 	@supplement = @control.supplement
  #   @related_controls = @supplement.nil? ? [] : @supplement.related.split(",")

  #   @enhancements = @control.children
  #   @enhancement_supplements = {}
  #   @enhancement_statements = {}

  #   @enhancements.each do |enhancement|
  #     @enhancement_supplements[enhancement.number] = enhancement.supplement
  #     @enhancement_statements[enhancement.number] = enhancement.statements
  #   end

  #   respond_to do |format|
  #     format.html {}
  #     format.json {
  #       render json: @control.as_json(except: [:id, :parent_id, :family_id, :created_at, :updated_at], include: [
  #         statements: { except: [:id, :control_id, :created_at, :updated_at] },
  #         references: { except: [:id, :control_id, :created_at, :updated_at] },
  #         supplement: { except: [:id, :control_id, :created_at, :updated_at] },
  #         children: { except: [:id, :parent_id, :family_id, :control_id, :created_at, :updated_at] }
  #       ])
  #     }
  #   end
  end
end
