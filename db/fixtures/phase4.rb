require 'csv'

csv = CSV.read('db/fixtures/phase4.csv')

csv.each_with_index do |phase4, i|
  # skip a label row
  next if i === 0

  choices_ja = phase4[1]
  response_ja = phase4[2]
  nextquestion_ja = phase4[3]
  phase3_id = phase4[4]
  context_id = phase4[5]
  phase = phase4[6]
  choices_en = phase4[7]
  response_en = phase4[8]
  nextquestion_en = phase4[9]

  Phase4.seed do |s|
    s.id   = i
    s.choices_ja = choices_ja
    s.response_ja = response_ja
    s.nextquestion_ja = nextquestion_ja
    s.phase3_id = phase3_id
    s.context_id = context_id
    s.phase = phase
    s.choices_en = choices_en
    s.response_en = response_en
    s.nextquestion_en = nextquestion_en
  end
end