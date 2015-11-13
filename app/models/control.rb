class Control < ActiveRecord::Base
  def self.search(search)
    @hits_hash = Hash.new

    if search && search.length > 0
      @hits_hash["title_hits"] = Control.where('((title LIKE :search) OR (number LIKE :search)) AND (is_enhancement = false)', search: "%#{search}%")
      @hits_hash["description_hits"] = Statement.where('(description LIKE :search)', search: "%#{search}%")
    else
      @hits_hash["title_hits"] = []
      @hits_hash["description_hits"] = []
    end

    @hits_hash
  end
end
