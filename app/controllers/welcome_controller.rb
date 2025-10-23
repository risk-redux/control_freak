class WelcomeController < ApplicationController
  def index
    @search = search_parameters
    @hits = Control.search(@search)

    @placeholder = Control.where(parent_id: nil).select(:title).sample(1).first.title[0..35]
  end

  private

  def search_parameters
    params[:search].to_s
  end
end
