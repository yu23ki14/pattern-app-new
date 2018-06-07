require 'csv'

csv = CSV.read('db/fixtures/languages.csv')

csv.each_with_index do |languages, i|
  # skip a label row
  next if i === 0

  lg_name_ja = languages[1]
  lg_code = languages[2]
  lg_name_en = languages[3]

  Language.seed do |s|
    s.id   = i
    s.lg_name_ja = lg_name_ja
    s.lg_code = lg_code
    s.lg_name_en = lg_name_en
  end
end