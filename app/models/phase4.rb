class Phase4 < ApplicationRecord
  belongs_to :phase3
  
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
