class Control < ActiveRecord::Base
	belongs_to :family
	has_many :statements
	has_many :references
	has_one :supplement


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

	def children
		@children = Control.where(parent_id: self.id)
	end

	def parent
		@par = Control.where(id: self.parent_id)

		if !@par.nil?
			return @par.first
		end
	end
end
