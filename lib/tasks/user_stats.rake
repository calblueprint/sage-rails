task :user_stats => :environment do
  puts "Printing stats"

  total_time = CheckIn.all.inject(0) { |total, cin| total += cin.calculate_time }
  puts "Total check in time: #{total_time}"

  check_in_count = CheckIn.all.size
  puts "Total check in count: #{check_in_count}"
end
