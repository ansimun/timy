require_relative "teatime/tracker"
require_relative "teatime/textreport"

module TeaTime
    def self.new(filename, taskname)
      tracker = Tracker.new.read(filename)
      tracker.new_task(taskname)
      tracker.write(filename)
    end
    
    def self.stop(filename)
      tracker = Tracker.new.read(filename)
      tracker.stop_task
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
      print_last_month(tracker, expression)
      print_this_month(tracker, expression)
      print_today(tracker, expression)
    end
    
    def self.print_today(tracker, expression)
      year_day = DateTime.now.yday
      report = TeaTime::TextReport.new("Today")
      report.last_task = tracker.last_task
      tracker.each_task do |task|
        if (task.start_time.yday == year_day && /#{expression}/i === task.name)
          report.add_task(task)
        end
      end
      report.print
    end
    
    def self.print_this_month(tracker, expression)
      date = DateTime.now
      report = TeaTime::TextReport.new(date.strftime("%B %Y"))
      report.last_task = tracker.last_task
      tracker.each_task do |task|
        if (task.start_time.month == date.month && /#{expression}/i === task.name)
          report.add_task(task)
        end
      end
      report.print
    end
    
    def self.print_last_month(tracker, expression)
      date = DateTime.now.prev_month
      report = TeaTime::TextReport.new(date.strftime("%B %Y"))
      report.last_task = tracker.last_task
      tracker.each_task do |task|
        if (task.start_time.month == date.month && /#{expression}/i === task.name)
          report.add_task(task)
        end
      end
      report.print
    end
    
 end
