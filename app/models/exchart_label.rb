class ExchartLabel < ApplicationRecord
  #this is sample code for create chartlabel
  #update exchart_labels set label_ja = E'コア,学びはじめ,実践での学び,学びの\n連鎖,鍛錬,実行力,発想,創造,仕上げ,学びの\n仲間,他者と\n関る,自省,突き抜け' where language_id = 1
  #update exchart_labels set label_ja = E'コア,勢いをもつ,まとまり,積極性,深い絆,創造の環境,発見の連鎖,実現へ加速,こだわり,つくり込み,継続の力' where language_id = 2
  #update exchart_labels set label_ja = E'コア,認識の共有,魅力的な\n展開,仕上げ,実感を\n生む工夫,つくり込み,能動性の誘発,準備,語り手,つながり,究極' where language_id = 3

  #update exchart_labels set label_en = E'core,begining,practicing,chain\nlearning,develop,action,abduction,process,finishing,fellow,influence,reflection,uniqueness' where language_id = 1
  #update exchart_labels set label_en = E'core,vigor,cohensive,activeness,bond,environment,nexus,accelerate,particular,fabricate,continuation' where language_id = 2
  #update exchart_labels set label_en = E'core,sharing recognition,attractive,finishing,real feeling,build up,activeness,preparation,storyteller,connection,ultimate' where language_id = 3

  def label
    self.send("label_#{I18n.locale}")
  end

end
