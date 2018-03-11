class Exchart < ApplicationRecord
  belongs_to :language
  belongs_to :user
  belongs_to :event
  
  #data1 すでに実践したい
  #data2 すでに実践しているものとしたいもの
end
