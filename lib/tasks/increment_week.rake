task :increment_week => :environment do
  puts "Incrementing week"
  IncrementWeekJob.new.perform
end
