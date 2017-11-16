class Phase3 < ApplicationRecord
  belongs_to :phase2
  has_many :phase4s
end
