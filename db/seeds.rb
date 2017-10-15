# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "csv"

CSV.foreach('db/csv/collaborationpattern.csv') do |row|
  Pattern.create(:lg_code => row[0], :cat_code => row[1], :pattern_no => row[2], :pattern_name => row[3], :summary => row[4], :context => row[5], :b_problem => row[6], :problem => row[7], :b_solution => row[8], :solution => row[9], :consequence => row[10])
end