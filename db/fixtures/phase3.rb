require 'csv'

csv = CSV.read('db/fixtures/phase3.csv')

csv.each_with_index do |phase3, i|
  # skip a label row
  next if i === 0

  choices = phase3[1]
  response = phase3[2]
  nextquestion = phase3[3]
  phase2_id = phase3[4]
  context_id = phase3[5]

  Phase3.seed do |s|
    s.id   = i
    s.choices = choices
    s.response = response
    s.nextquestion = nextquestion
    s.phase2_id = phase2_id
    s.context_id = context_id
  end
end