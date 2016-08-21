require "optparse"

class Arguments
  HELP = "--help"
  LIST = "--list"
  LIST_DAYS = "--list-days"
  NEW = "--new"
  START = "--start"
  STOP = "--stop"

  attr_reader :command, :taskname, :expression, :banner

  def initialize(command_line_args)
    @command = LIST

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
      parser.on(LIST_DAYS, "List tasks sorted by days") do
        @command = LIST_DAYS
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
