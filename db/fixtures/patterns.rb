require 'csv'

csv = CSV.read('db/fixtures/patterns.csv')

csv.each_with_index do |patterns, i|
  # skip a label row
  next if i === 0

  lg_code = patterns[1]
  cat_code = patterns[2]
  cat_code_24 = patterns[3]
  axis_no = patterns[4]
  pattern_no = patterns[5]
  pattern_name_ja = patterns[6]
  summary_ja = patterns[7]
  context_ja = patterns[8]
  b_problem_ja = patterns[9]
  problem_ja = patterns[10]
  b_solution_ja = patterns[11]
  solution_ja = patterns[12]
  consequence_ja = patterns[13]
  pattern_name_en = patterns[14]
  summary_en = patterns[15]
  context_en = patterns[16]
  b_problem_en = patterns[17]
  problem_en = patterns[18]
  b_solution_en = patterns[19]
  solution_en = patterns[20]
  consequence_en = patterns[21]
  learning_style_identifier = patterns[22]

  Pattern.seed do |s|
    s.id   = i
    s.language_id = lg_code
    s.cat_code = cat_code
    s.cat_code_24 = cat_code_24
    s.axis_no = axis_no
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
    s.learning_style_identifier = learning_style_identifier
  end
end