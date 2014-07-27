namespace :fake do 
  
  desc "add fake Users "
  task :users => :environment do
     (1..10).each do |i|
      User.create({email: "test#{i}@gmail.com",password: '12345678'})
      puts "create test#{i}@gmail.com"
    end
  end
end