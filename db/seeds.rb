# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "csv"

#CSV.foreach('db/csv/languages.csv') do |row|
#  Language.create(:lg_name => row[0], :lg_code => row[1])
#end

#CSV.foreach('db/csv/patterns.csv') do |row|
#  Pattern.create(:language_id => row[0], :cat_code => row[1], :cat_code_24 => row[2], :pattern_no => row[3], :pattern_name => row[4], :summary => row[5], :context => row[6], :b_problem => row[7], :problem => row[8], :b_solution => row[9], :solution => row[10], :consequence => row[11])
#end