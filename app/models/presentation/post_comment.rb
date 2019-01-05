class Presentation::PostComment < ApplicationRecord
  
  belongs_to :presentation_post, class_name: "Presentation::Post"
  belongs_to :user
end
