class Phase2 < ApplicationRecord
  belongs_to :phase1
  has_many :phase3s
end
