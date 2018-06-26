require 'csv'

csv = CSV.read('db/fixtures/phase1.csv')

csv.each_with_index do |phase1, i|
  # skip a label row
  next if i === 0

  choices_ja = phase1[1]
  response_ja = phase1[2]
  nextquestion_ja = phase1[3]
  choices_en = phase1[4]
  response_en = phase1[5]
  nextquestion_en = phase1[6]

  Phase1.seed do |s|
    s.id   = i
    s.choices_ja = choices_ja
    s.response_ja = response_ja
    s.nextquestion_ja = nextquestion_ja
    s.choices_en = choices_en
    s.response_en = response_en
    s.nextquestion_en = nextquestion_en
  end
end