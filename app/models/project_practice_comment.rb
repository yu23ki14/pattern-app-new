class ProjectPracticeComment < ApplicationRecord
  belongs_to :project_practice
  belongs_to :user
end
