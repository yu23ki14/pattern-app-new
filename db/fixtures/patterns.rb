require 'csv'

csv = CSV.read('db/fixtures/patterns.csv')

csv.each_with_index do |patterns, i|
  # skip a label row
  next if i === 0

  lg_code = patterns[1]
  cat_code = patterns[2]
  cat_code_24 = patterns[3]
  pattern_no = patterns[4]
  pattern_name = patterns[5]
  summary = patterns[6]
  context = patterns[7]
  b_problem = patterns[8]
  problem = patterns[9]
  b_solution = patterns[10]
  solution = patterns[11]
  consequence = patterns[12]

  Pattern.seed do |s|
    s.id   = i
    s.language_id = lg_code
    s.cat_code = cat_code
    s.cat_code_24 = cat_code_24
    s.pattern_no = pattern_no
    s.pattern_name = pattern_name
    s.summary = summary
    s.context = context
    s.b_problem = b_problem
    s.problem = problem
    s.b_solution = b_solution
    s.solution = solution
    s.consequence = consequence
  end
end