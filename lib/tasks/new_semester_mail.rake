namespace :new_semester_mail do
  desc "send new semester mail"
  
  task :send => :environment do
    sougo = Event.find(1)
    kankyo = Event.find(1)
    
    users_id = (sougo.excharts.pluck(:user_id) + kankyo.excharts.pluck(:user_id)).uniq!
    users_address = User.where(id: users_id).pluck(:email)
    
    print users_address
    #NewSemesterMailer(users_address)
  end
  
end