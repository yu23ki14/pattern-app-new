require 'csv'

csv = CSV.read('db/fixtures/phase2.csv')

csv.each_with_index do |phase2, i|
  # skip a label row
  next if i === 0

  choices_ja = phase2[1]
  response_ja = phase2[2]
  nextquestion_ja = phase2[3]
  phase1_id = phase2[4]
  phase = phase2[5]
  choices_en = phase2[6]
  response_en = phase2[7]
  nextquestion_en = phase2[8]

  Phase2.seed do |s|
    s.id   = i
    s.choices_ja = choices_ja
    s.response_ja = response_ja
    s.nextquestion_ja = nextquestion_ja
    s.phase1_id = phase1_id
    s.phase = phase
    s.choices_en = choices_en
    s.response_en = response_en
    s.nextquestion_en = nextquestion_en
  end
end