class Control < ActiveRecord::Base
  belongs_to :family
  has_many :statements
  has_many :references
  has_one :supplement
  has_one :withdrawal

  def self.search(search)
    @hits_hash = Hash.new

    if search && search.length > 0
      controls = Control.where(is_enhancement: false)
      statements = Statement.all
      
      regexp_search = Regexp.new(search, Regexp::IGNORECASE)

      @hits_hash["title_hits"] = controls.select{ |row| regexp_search.match(row.title) || regexp_search.match(row.number) }
      @hits_hash["description_hits"] = statements.select{ |row| regexp_search.match(row.description) }
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
