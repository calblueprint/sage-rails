task :set_active => :environment do
  puts "Setting active all students"
  SetActiveJob.new.perform
end
