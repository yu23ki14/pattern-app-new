require 'csv'

csv = CSV.read('db/fixtures/patterns.csv')

csv.each_with_index do |patterns, i|
  # skip a label row
  next if i === 0

  lg_code = patterns[1]
  cat_code = patterns[2]
  cat_code_24 = patterns[3]
  pattern_no = patterns[4]
  pattern_name_ja = patterns[5]
  summary_ja = patterns[6]
  context_ja = patterns[7]
  b_problem_ja = patterns[8]
  problem_ja = patterns[9]
  b_solution_ja = patterns[10]
  solution_ja = patterns[11]
  consequence_ja = patterns[12]
  pattern_name_en = patterns[13]
  summary_en = patterns[14]
  context_en = patterns[15]
  b_problem_en = patterns[16]
  problem_en = patterns[17]
  b_solution_en = patterns[18]
  solution_en = patterns[19]
  consequence_en = patterns[20]

  Pattern.seed do |s|
    s.id   = i
    s.language_id = lg_code
    s.cat_code = cat_code
    s.cat_code_24 = cat_code_24
    s.pattern_no = pattern_no
    s.pattern_name_ja = pattern_name_ja
    s.summary_ja = summary_ja
    s.context_ja = context_ja
    s.b_problem_ja= b_problem_ja
    s.problem_ja = problem_ja
    s.b_solution_ja = b_solution_ja
    s.solution_ja = solution_ja
    s.consequence_ja = consequence_ja
    s.pattern_name_en = pattern_name_en
    s.summary_en = summary_en
    s.context_en = context_en
    s.b_problem_en= b_problem_en
    s.problem_en = problem_en
    s.b_solution_en = b_solution_en
    s.solution_en = solution_en
    s.consequence_en = consequence_en
  end
end