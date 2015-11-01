# 
#    Copyright (C) 2015 Andreas Siegemund (smumm)
#    
#    This library is free software; you can redistribute it and/or
#    modify it under the terms of the GNU Lesser General Public
#    License as published by the Free Software Foundation; either
#    version 2.1 of the License, or any later version.
#
#    This library is WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#    Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public
#    License along with this library.
#    

require "csv"
require_relative "task"

module Timy
  class Tracker
    @tasks
    
    def initialize()
      @tasks = Array.new
    end
    
    def read(filename)
      @tasks.clear
      CSV.parse(IO.read(filename), :col_sep => ";") do |row|
        @tasks.push(read_task_row(row))
      end
      return self
    end
    
    def write(filename)
      csv_table = CSV.generate(:col_sep => ";") do |csv|
        @tasks.each do |task|
          csv << [task.name, build_time_string(task.start_time), build_time_string(task.end_time)]
        end
      end
      IO.write(filename, csv_table)
      return nil
    end
    
    def start_task(taskname)
      task = @tasks.find {|task| task.name == taskname}
      if (task != nil)
        new_task(task.name)
      end
      return self
    end
    
    def new_task(taskname)
      stop_task
      @tasks.push(Task.new(taskname, DateTime.now))
      return self
    end
    
    def stop_task()
      @tasks.last.stop unless @tasks.last.nil?
      return self
    end
    
    def last_task()
      return @tasks.last.clone unless @tasks.last.nil?
      return nil
    end
    
    def each_task()
      @tasks.each do |task|
        yield task.clone #prevent modifications for given task
      end      
      
      return nil
    end
    
    def find_tasks(pattern)
      return @tasks.find_all {|task| /#{pattern}/i === task.name}.select{ |task| task.clone  }
    end
    
    private
    
    def read_task_row(row)
      raise "Invalid data count in csv row - should be 3 but is #{row.count}" unless row.count == 3
      result = Task.new(row[0], row[1], row[2])
      return result;
    end
    
    def build_time_string(time)
      return (time.nil?)? nil : time.to_s
    end
    
  end
end
