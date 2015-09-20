require "date"
require_relative "timy/tracker"
require_relative "timy/textreport"

module Timy
  def self.new(filename, taskname)
    tracker = Tracker.new.read(filename)
    tracker.new_task(taskname)
    print_info("Start new task '#{tracker.last_task.name}'")
    print_todays_tasks(tracker, ".*")
    tracker.write(filename)
  end
    
  def self.start(filename, taskname_pattern)
    tracker = Tracker.new.read(filename)
    matching_tasks = tracker.find_tasks(taskname_pattern)
    if (matching_tasks.count > 0)
      tracker.start_task(matching_tasks.last.name)
      tracker.write(filename)
      print_info("Start task '#{matching_tasks.last.name}'")
    else
      print_info("No matching task found for '#{taskname_pattern}'")
    end
    print_todays_tasks(tracker, ".*")
  end
    
  def self.stop(filename)
    tracker = Tracker.new.read(filename)
    tracker.stop_task
    print_info("Stop task '#{tracker.last_task.name}")    
    print_todays_tasks(tracker, ".*")
    tracker.write(filename)
  end
    
  def self.list(filename)
    tracker = Tracker.new.read(filename)
    tracker.each_task do |task|
      puts "#{task.name}"
      puts "\t#{task.start_time} - #{task.end_time} : #{task.elapsed_hours.round(2)} hours"
    end
  end
    
  def self.print(filename, expression)
    tracker = Tracker.new.read(filename)
    print_prevmonths_tasks(tracker, expression)
    print_months_tasks(tracker, expression)
    print_todays_tasks(tracker, expression)
  end

  def self.print_days(filename, expression)
    tracker = Tracker.new.read(filename)
    first_day = tracker.first_task.start_time.to_date
    last_day = tracker.last_task.start_time.to_date
    (first_day..last_day).each do |day|
      print_timespan(tracker, expression, day, day, day)
    end
  end
  
  def self.print_todays_tasks(tracker, expression)
    today = DateTime.now
    print_timespan(tracker, expression, "Today", today, today)    
  end
  
  def self.print_months_tasks(tracker, expression)
    today = DateTime.now
    print_timespan(tracker, expression, today.strftime("%B %Y"),
      Date.new(today.year, today.month, 1),
      Date.new(today.year, today.month, -1))
  end

  def self.print_prevmonths_tasks(tracker, expression)
    prev_month = DateTime.now.prev_month
    print_timespan(tracker, expression, prev_month.strftime("%B %Y"), 
      Date.new(prev_month.year, prev_month.month, 1), 
      Date.new(prev_month.year, prev_month.month, -1))
  end
    
  def self.print_info(info)
    puts "> #{info}"
  end
  
  def self.print_timespan(tracker, expression, name, start_date, end_date)
    report = TextReport.new(name)
    report.last_task = tracker.last_task
    tracker.each_task do |task|
      if (task.start_time.mjd >= start_date.mjd && task.start_time.mjd <= end_date.mjd &&  /#{expression}/i === task.name)
        report.add_task(task)
      end
    end
    report.print
  end
end
