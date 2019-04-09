namespace :new_semester_mail do
  desc "send new semester mail"
  
  task :send, ["index"] => :environment do |task, vars|
    sougo = Event.find(5)
    kankyo = Event.find(6)
    
    users_id = (sougo.excharts.pluck(:user_id) + kankyo.excharts.pluck(:user_id)).uniq!
    x = vars.index.to_i * 50
    y = vars.index.to_i * 50 + 49
    users_address = User.where(id: users_id).pluck(:email)[x..y]
    p users_address
    #NewSemesterMailer.send_2018(users_address).deliver
  end
  
end