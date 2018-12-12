class Presentation::Post < ApplicationRecord
    has_one_attached :thumb_image
    
    belongs_to :user
    has_many :presentation_post_comments
end
