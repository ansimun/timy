require_relative "teatime/timetable"
require_relative "teatime/textreport"
require_relative "teatime"

module TeaTime
    def self.read(filename)
      return TimeTable.new(IO.read(filename))
    end
    
    def self.write(filename, timetable)
      IO.write(filename, timetable.to_csv)
    end
    
    def self.new(filename, taskname)
      times = read(filename)
      times.last.stop unless times.last.nil?
      task = TeaTime::Task.new(taskname, DateTime.now)
      times.add(task)
      write(filename, times)
    end
    
    def self.stop(filename)
      times = read(filename)
      times.last.stop unless times.last.nil?
      write(filename, times)
    end
    
    def self.list(filename)
      times = read(filename)
      times.each do |task|
        puts "#{task.name}"
        puts "\t#{task.start_time} - #{task.end_time} : #{task.elapsed_hours.round(2)} hours"
      end
    end
    
    def self.print(filename)
      times = read(filename)
      print_last_month(times)
      print_this_month(times)
      print_today(times)
    end
    
    def self.print_today(times)
      year_day = DateTime.now.yday
      report = TeaTime::TextReport.new("Today")
      report.last_task = times.last
      times.each do |task|
        report.add_task(task) if task.start_time.yday == year_day
      end
      report.print
    end
    
    def self.print_this_month(times)
      date = DateTime.now
      report = TeaTime::TextReport.new(date.strftime("%B %Y"))
      report.last_task = times.last
      times.each do |task|
        report.add_task(task) if task.start_time.month == date.month
      end
      report.print
    end
    
    def self.print_last_month(times)
      date = DateTime.now.prev_month
      report = TeaTime::TextReport.new(date.strftime("%B %Y"))
      report.last_task = times.last
      times.each do |task|
        report.add_task(task) if task.start_time.month == date.month
      end
      report.print
    end
    
 end
