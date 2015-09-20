require "fileutils"
require_relative "timy"
require_relative "arguments"

args = Arguments.new(ARGV)

filename = File.join(Dir.home,"Times.txt")
FileUtils.touch(filename) unless File.exist?(filename)

if (args.command == Arguments::HELP)
  puts args.banner
elsif (args.command == Arguments::LIST)
  Timy.list(filename)
elsif (args.command == Arguments::NEW)
  Timy.new(filename, args.taskname)
elsif (args.command == Arguments::START)
  Timy.start(filename, args.taskname)
elsif (args.command == Arguments::STOP)
  Timy.stop(filename)
elsif (args.command == Arguments::PRINT)
  Timy.print(filename, args.expression)
elsif (args.command == Arguments::PRINT_DAYS)
  Timy.print_days(filename, args.expression)
end