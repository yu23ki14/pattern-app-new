class Presentation::UserInterest < ApplicationRecord
    belongs_to :user
    belongs_to :pattern
end