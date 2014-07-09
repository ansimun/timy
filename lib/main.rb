require_relative "teatime"
require_relative "teatime/arguments"

args = TeaTime::Arguments.new(ARGV)

times = TeaTime.read("C:/Users/siegemund/Times.txt")

if (args.command == TeaTime::Arguments::LIST)
  times.each do |task|
    puts "#{task.name}"
    puts "\t#{task.start_time} - #{task.end_time} : #{task.elapsed_hours.round(2)} hours"
  end
elsif (args.command == TeaTime::Arguments::STOP)
  task = times.last
  task.stop if !times.last.nil? && times.last.active?
elsif (args.command == TeaTime::Arguments::NEW)
  times.last.stop if !times.last.nil? && times.last.active?
  task = TeaTime::Task.new(args.taskname, DateTime.now)
  times.add(task)
elsif (args.command == TeaTime::Arguments::REPORT)
  
else
  puts "Invalid argument(s) #{ARGV}"
end

TeaTime.write("C:/Users/siegemund/Times.txt", times)