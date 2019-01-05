class Pattern < ApplicationRecord
  belongs_to :language
  has_many :favorites
  has_many :practices
  has_many :presentation_user_interests
  has_many :presentation_post_pattern_relate, class_name: "Presentation::PostPatternRelate", foreign_key: "pattern_id"
  has_many :presentation_related_posts, through: :presentation_post_pattern_relate, class_name: "Presentation::Post", source: :presentation_post
  has_many :presentation_user_interests, class_name: "Presentation::UserInterest", foreign_key: :pattern_id
  has_many :presentation_followed_users, through: :presentation_user_interests, class_name: "Pattern", source: :user
  
  scope :this_pattern, -> (language_id, pattern_no) { where(language_id: language_id).find_by(pattern_no: pattern_no) }
  
  def pattern_name
    self.send("pattern_name_#{I18n.locale}")
  end
  
  def summary
    self.send("summary_#{I18n.locale}")
  end
  
  def context
    self.send("context_#{I18n.locale}")
  end
  
  def b_problem 
    self.send("b_problem_#{I18n.locale}")
  end
  
  def problem
    self.send("problem_#{I18n.locale}")
  end
  
  def b_solution 
    self.send("b_solution_#{I18n.locale}")
  end
  
  def solution
    self.send("solution_#{I18n.locale}")
  end
  
  def consequence
    self.send("consequence_#{I18n.locale}")
  end
  
end
