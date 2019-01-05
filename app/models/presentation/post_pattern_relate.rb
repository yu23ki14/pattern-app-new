class Presentation::PostPatternRelate < ApplicationRecord
    belongs_to :presentation_post, class_name: "Presentation::Post"
    belongs_to :pattern
end
