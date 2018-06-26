class Phase3 < ApplicationRecord
  belongs_to :phase2
  has_many :phase4s
  
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
