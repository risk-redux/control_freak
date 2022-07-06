class AboutController < ApplicationController
  def index
    @catalog = Catalog.order('id DESC').first
  end
end
