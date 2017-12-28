class Project < ApplicationRecord
  has_many :project_practices, :dependent => :destroy
  has_many :project_members, :dependent => :destroy
  has_many :users, through: :project_members

  before_create do
    self.project_id = self.project_id + [*1..9, *'A'..'Z', *'a'..'z'].sample(4).join
  end
end
