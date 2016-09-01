task weekly_tasks: :environment do
  # unless Date.today.wday == 0
  #   puts 'Ran job, not sunday'
  #   next
  # end

  semester_task = SemesterTask.between(Time.now - 1.day, Time.now).first
  unless semester_task
    puts "No Semester task, creating one"
    semester_task = SemesterTask.create
  end

  unless semester_task.set_active?
    puts 'Setting active all students'
    SetActiveJob.new.perform
    semester_task.update_attribute(:set_active, true)
  end

  unless semester_task.increment_week?
    puts 'Incrementing week'
    IncrementWeekJob.new.perform
    semester_task.update_attribute(:increment_week, true)
  end
end
