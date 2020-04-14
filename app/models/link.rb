class Link < ApplicationRecord
  belongs_to :ctrl, optional: true
end