class ProjectPractice < ApplicationRecord
  belongs_to :project
  before_create do
    self.enddate = Time.now + limit*86400
    self.lastdate = Time.now - 43200
  end
end