namespace :dev do 
  
  desc "Rebuild System"
  task :build => ["tmp:clear","log:clear","db:drop","db:create","db:migrate","db:seed"]
  
end