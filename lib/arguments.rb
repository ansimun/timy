require "optparse"

class Arguments
  HELP = "--help"
  LIST = "--list"
  NEW = "--new"
  START = "--start"
  STOP = "--stop"
  PRINT = "--print"
  PRINT_DAYS = "--print-days"
  FILTER = "--filter"
    
  attr_reader :command, :taskname, :expression, :banner
    
  def initialize(command_line_args)
    @command = PRINT
    
    parser = OptionParser.new do |parser|
      parser.on("-h", "#{HELP}", "Display this help") do
        @command = HELP
      end
      parser.on("-n", "#{NEW} TASKNAME", "Create a new task with the given name") do |taskname|
        @command = NEW
        @taskname = taskname
      end
      parser.on("-t", "#{START} PATTERN", "Start the last task matching the given pattern") do |pattern|
        @command = START
        @taskname = pattern
      end
      parser.on("-s", STOP, "Stop the last task.") do
        @command = STOP
      end
      parser.on("-l", LIST, "List all tasks") do
        @command = LIST
      end
      parser.on("-r", PRINT, "Create a report over all tasks (default)") do
        @command = PRINT
      end
      parser.on(PRINT_DAYS, "Create a report over all days") do
        @command = PRINT_DAYS
      end
      parser.on("#{FILTER} PATTERN", "Print only tasks matching the given pattern") do |expression|
        @expression = expression
      end
    end
      
    @banner = parser.to_s
    
    begin
      parser.parse!(command_line_args)
    rescue
      raise "Error while parsing command line\n#{@banner}"
    end
  end
end
