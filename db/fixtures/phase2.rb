require 'csv'

csv = CSV.read('db/fixtures/phase2.csv')

csv.each_with_index do |phase2, i|
  # skip a label row
  next if i === 0

  choices = phase2[1]
  response = phase2[2]
  nextquestion = phase2[3]
  phase1_id = phase2[4]

  Phase2.seed do |s|
    s.id   = i
    s.choices = choices
    s.response = response
    s.nextquestion = nextquestion
    s.phase1_id = phase1_id
  end
end