class Phase2 < ApplicationRecord
  belongs_to :phase1
  has_many :phase3s
  
  def choices
    self.send("choices_#{I18n.locale}")
  end
  
  def response
    self.send("response_#{I18n.locale}")
  end
  
  def nextquestion
    self.send("nextquestion_#{I18n.locale}")
  end
end
