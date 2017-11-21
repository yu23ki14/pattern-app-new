require 'csv'

csv = CSV.read('db/fixtures/languages.csv')

csv.each_with_index do |languages, i|
  # skip a label row
  next if i === 0

  lg_name = languages[1]
  lg_code = languages[2]

  Language.seed do |s|
    s.id   = i
    s.lg_name = lg_name
    s.lg_code = lg_code
  end
end