require "csv"
require_relative "task"

module TeaTime
  class TimeTable
    
    @tasks
    
    def initialize(csv_text)
      @tasks = Array.new
      CSV.parse(csv_text, :col_sep => ";") do |row|
        @tasks.push(read_csv_row(row))
      end
    end
    
    def to_csv()
      CSV.generate(:col_sep => ";") do |csv|
        @tasks.each do |task|
          csv << [task.name, build_time_string(task.start_time), build_time_string(task.end_time)]
        end
      end
    end
    
    def count()
      return @tasks.count
    end
    
    def last()
      return @tasks[-1] unless @tasks.empty?
      return nil if @tasks.empty?
    end
    
    def add(task)
      if (@tasks.count > 0)
        @tasks.last.stop
        @tasks.last.freeze
      end
      @tasks.push(task)
    end
    
    def each(&block)
      @tasks.each do |task|
        yield task
      end
    end
    
    private
    
    def read_csv_row(row)
      raise "Invalid data count in csv row - should be 3 but is #{row.count}" unless row.count == 3
      result = Task.new(row[0], row[1], row[2])
      return result;
    end
    
    def build_time_string(time)
      return nil if time.nil?
      return time.to_s
    end
  end
end
