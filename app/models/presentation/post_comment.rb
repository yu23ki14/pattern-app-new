class Presentation::PostComment < ApplicationRecord
  belongs_to :presentation_post
  belongs_to :user
end
