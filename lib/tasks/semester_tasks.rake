task set_active: :environment do
  puts "Setting active all students"
  SetActiveJob.new.perform
end

task increment_week: :environment do
  puts "Incrementing week"
  IncrementWeekJob.new.perform
end
