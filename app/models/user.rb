class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :timeoutable, :trackable, :validatable
  has_many :favorites
  has_many :practices
  has_many :recommends
  has_many :project_members
  has_many :projects, through: :project_members
  has_many :project_practice_comments
  has_many :excharts
  has_many :events
  has_many :learning_styles

  has_many :presentation_posts, class_name: "Presentation::Post", dependent: :delete_all
  has_many :presentation_post_comments, class_name: "Presentation::PostComment", dependent: :delete_all
  has_many :presentation_stocks, class_name: "Presentation::Stock", foreign_key: :user_id, dependent: :delete_all
  has_many :presentation_stocked_posts, through: :presentation_stocks, class_name: "Presentation::Post", source: :presentation_post
  has_many :presentation_user_interests, class_name: "Presentation::UserInterest", foreign_key: :user_id, dependent: :delete_all
  has_many :presentation_following_patterns, through: :presentation_user_interests, class_name: "Pattern", source: :pattern
end