class Presentation::Post < ApplicationRecord
    
    has_one_attached :thumb_image
    
    has_many :presentation_post_comments, class_name: "Presentation::PostComment",foreign_key: "presentation_post_id", dependent: :delete_all
    has_many :presentation_stocks, class_name: "Presentation::Stock",foreign_key: "presentation_post_id", dependent: :delete_all
    has_many :users, through: :presetation_stocks
    has_many :presentation_post_pattern_relates, class_name: "Presentation::PostPatternRelate", foreign_key: "presentation_post_id", dependent: :delete_all
    has_many :patterns, through: :presentation_post_pattern_relates
    
    validates :title, presence: true
    
    enum state: {draft: 0, publish: 1, illegal: 2}
    enum post_type: {free: 0, book: 1, web: 2, video: 3}
    
    def related_posts
        ids = []
        patterns = self.patterns
        patterns.each do |pattern|
            ids += pattern.presentation_related_posts.pluck(:id)
        end
        return Presentation::Post.where(id: ids).with_attached_thumb_image.includes(:patterns)
    end
end
