class Presentation::Stock < ApplicationRecord
  
  belongs_to :user
  belongs_to :presentation_post, class_name: "Presentation::Post"
end
