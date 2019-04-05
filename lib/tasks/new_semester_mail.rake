namespace :new_semester_mail do
  desc "send new semester mail"
  
  task :send => :environment do
    users_address = []
    sougo = Event.find(5)
    kankyo = Event.find(6)
    
    users_address.push(sougo.users.pluck(:email)).push(kankyo.users.pluck(:email))
    users_address.uniq!
    
    print users_address
    #NewSemesterMailer(users_address)
  end
  
end