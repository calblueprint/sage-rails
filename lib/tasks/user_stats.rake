task :all_user_stats => :environment do
  puts "Printing stats for all semesters"

  total_time = CheckIn.all.inject(0) { |total, cin| total += cin.calculate_time }
  puts "Total check in time: #{total_time}"

  check_in_count = CheckIn.all.size
  puts "Total check in count: #{check_in_count}"
end

task :current_user_stats => :environment do
  puts "Printing stats for current semester"

  semester = Semester.current_semester.first
  unless semester
    puts "No current semester"
    next
  end

  total_time = semester.check_ins.all.inject(0) { |total, cin| total += cin.calculate_time }
  puts "Total check in time: #{total_time}"

  check_in_count = semester.check_ins.all.size
  puts "Total check in count: #{check_in_count}"
end
