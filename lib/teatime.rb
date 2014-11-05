require "date"
require_relative "teatime/tracker"
require_relative "teatime/textreport"

module TeaTime
  def self.new(filename, taskname)
    tracker = Tracker.new.read(filename)
    tracker.new_task(taskname)
    print_last_task(tracker, "New Active Task")
    tracker.write(filename)
  end
    
  def self.start(filename, taskname_pattern)
    tracker = Tracker.new.read(filename)
    matching_tasks = tracker.find_tasks(taskname_pattern)
    if (matching_tasks.count > 0)
      tracker.start_task(matching_tasks.last.name)
      tracker.write(filename)
    end
    print_last_task(tracker, "Active Task")
  end
    
  def self.stop(filename)
    tracker = Tracker.new.read(filename)
    tracker.stop_task
    print_last_task(tracker, "Last Active Task")
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
    today = DateTime.now
    prev_month = DateTime.now.prev_month
    tracker = Tracker.new.read(filename)
    print_timespan(tracker, expression, prev_month.strftime("%B %Y"), 
      Date.new(prev_month.year, prev_month.month, 1), 
      Date.new(prev_month.year, prev_month.month, -1))
    print_timespan(tracker, expression, today.strftime("%B %Y"),
      Date.new(today.year, today.month, 1),
      Date.new(today.year, today.month, -1))
    print_timespan(tracker, expression, "Today", today, today)
  end

  def self.print_last_task(tracker, reportname)
    report = TeaTime::TextReport.new(reportname)
    report.last_task = tracker.last_task
    report.print_total = false
    tracker.each_task do |task|
      if (report.last_task.start_time.mjd == task.start_time.mjd && task.name == report.last_task.name)
        report.add_task(task)
      end
    end
    report.print
  end
  
  def self.print_timespan(tracker, expression, name, start_date, end_date)
    report = TeaTime::TextReport.new(name)
    report.last_task = tracker.last_task
    tracker.each_task do |task|
      if (task.start_time.mjd >= start_date.mjd && task.start_time.mjd <= end_date.mjd &&  /#{expression}/i === task.name)
        report.add_task(task)
      end
    end
    report.print
  end
end
