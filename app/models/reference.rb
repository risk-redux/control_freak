class Reference < ApplicationRecord
  has_many :ctrls, through: :links
end
