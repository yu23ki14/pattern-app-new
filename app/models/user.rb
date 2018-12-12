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
  has_many :presentation_posts
  has_many :presentation_user_interests
  has_many :presentatino_post_comments
end
