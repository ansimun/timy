require_relative "teatime"
require_relative "teatime/arguments"

args = TeaTime::Arguments.new(ARGV)

filename = "C:/Users/siegemund/Times.txt"

if (args.command == TeaTime::Arguments::LIST)
  TeaTime.list(filename)
elsif (args.command == TeaTime::Arguments::STOP)
  TeaTime.stop(filename)
elsif (args.command == TeaTime::Arguments::NEW)
  TeaTime.new(filename, args.taskname)
elsif (args.command == TeaTime::Arguments::PRINT)
  TeaTime.print(filename)
else
  puts "Invalid argument(s) #{ARGV}"
end
