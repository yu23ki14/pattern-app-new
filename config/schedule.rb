set :output, "log/crontab.log"
set :environment, ENV["RAILS_ENV"]

every :monday, :at => '8am' do
  rake "monday_mail:send_practice"
  rake "monday_mail:send_project"
end