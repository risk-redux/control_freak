class Control < ApplicationRecord
  belongs_to :family, optional: true
  belongs_to :parent, class_name: 'Control', optional: true
  has_many :children, foreign_key: :parent_id, class_name: 'Control'
  has_many :parameters
  has_many :links
  has_many :parts

  def self.search(search)
    @hits_hash = Hash.new

    if search && search.length > 0
      controls = Control.where(parent_id: nil)
      parts = Part.all
      
      regexp_search = Regexp.new(search, Regexp::IGNORECASE)

      @hits_hash["title_hits"] = controls.select{ |row| regexp_search.match(row.title) || regexp_search.match(row.number) || regexp_search.match(row.sort_number) }
      @hits_hash["prose_hits"] = parts.select{ |row| regexp_search.match(row.prose) }
    else
      @hits_hash["title_hits"] = []
      @hits_hash["prose_hits"] = []
    end

    @hits_hash
  end
end
