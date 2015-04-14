class WelcomeController < ApplicationController
  def index
    @hits = Control.search(params[:search])
  end
end
