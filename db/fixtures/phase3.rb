require 'csv'

csv = CSV.read('db/fixtures/phase3.csv')

csv.each_with_index do |phase3, i|
  # skip a label row
  next if i === 0

  choices_ja = phase3[1]
  response_ja = phase3[2]
  nextquestion_ja = phase3[3]
  phase2_id = phase3[4]
  context_id = phase3[5]
  phase = phase3[6]
  choices_en = phase3[7]
  response_en = phase3[8]
  nextquestion_en = phase3[9]

  Phase3.seed do |s|
    s.id   = i
    s.choices_ja = choices_ja
    s.response_ja = response_ja
    s.nextquestion_ja = nextquestion_ja
    s.phase2_id = phase2_id
    s.context_id = context_id
    s.phase = phase
    s.choices_en = choices_en
    s.response_en = response_en
    s.nextquestion_en = nextquestion_en
  end
end