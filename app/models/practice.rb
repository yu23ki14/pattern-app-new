class Practice < ApplicationRecord
  belongs_to :user
  belongs_to :pattern
  belongs_to :language
  
  before_save do
    self.enddate = Time.now + limit*86400
  end
end
