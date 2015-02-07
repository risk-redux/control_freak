class FamiliesController < ApplicationController
  def index
    @families = Family.all
    puts @families[0][:name]
    @family_count = @families.size
  end
end
