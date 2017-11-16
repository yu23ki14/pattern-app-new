require 'csv'

csv = CSV.read('db/fixtures/phase4.csv')

csv.each_with_index do |phase4, i|
  # skip a label row
  next if i === 0

  choices = phase4[1]
  response = phase4[2]
  nextquestion = phase4[3]
  phase3_id = phase4[4]
  context_id = phase4[5]

  Phase4.seed do |s|
    s.id   = i
    s.choices = choices
    s.response = response
    s.nextquestion = nextquestion
    s.phase3_id = phase3_id
    s.context_id = context_id
  end
end