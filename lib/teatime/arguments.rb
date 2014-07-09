require "optparse"

BANNER = %Q{
Usage: [--list|--stop|--new [taskname]]
    available commands:
        --list   Lists all tasks (default)
        --new    Creates a new task with given taskname
        --stop   Stops the active task
        --report Creates a summary for all tasks

}

module TeaTime
  class Arguments
    LIST = "--list"
    NEW = "--new"
    STOP = "--stop"
    REPORT = "--report"
    
    attr_reader :command, :taskname
    
    def initialize(command_line_args)
      @command = LIST
      parser = OptionParser.new do |parser|
        parser.on("-n", "#{NEW} TASKNAME", "Create a new task 'TASKNAME'") do |taskname|
          @command = NEW
          @taskname = taskname
        end
        parser.on("-s", STOP, "Close the last task.") do
          @command = STOP
        end
        parser.on("-l", LIST, "Lists all tasks") do
          @command = LIST
        end
        parser.on("-r", REPORT, "Creates a report over all tasks") do
          @command = REPORT
        end
      end
      
      begin
        parser.parse!(command_line_args)
      rescue
        raise "Error while parsing command line\n#{BANNER}"
      end
    end
  end
end
