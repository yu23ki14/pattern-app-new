require 'csv'

csv = CSV.read('db/fixtures/phase1.csv')

csv.each_with_index do |phase1, i|
  # skip a label row
  next if i === 0

  choices = phase1[1]
  response = phase1[2]
  nextquestion = phase1[3]

  Phase1.seed do |s|
    s.id   = i
    s.choices = choices
    s.response = response
    s.nextquestion = nextquestion
  end
end