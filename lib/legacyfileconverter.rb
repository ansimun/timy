#    Copyright (C) 2016 Andreas Siegemund (smumm)
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
require "fileutils"
require_relative "timy/taskfile"
require_relative "timy/task"

legacy_filename = File.join(Dir.home,"Times.txt")

taskmap = Hash.new
CSV.parse(IO.read(legacy_filename), :col_sep => ";") do |row|
  name = row[0]
  start_time = DateTime.parse(row[1]).new_offset(0)
  stop_time = DateTime.parse(row[2]).new_offset(0) unless row[2].nil?
  stop_time = nil if row[2].nil?

  unless (taskmap.has_key?(name))
    taskmap[name] = Timy::Task.new(name)
    puts "Create new task '#{name}'"
  end
  taskmap[name].times.push(Timy::TimeRange.new(start_time, stop_time))
end

FileUtils.rm_rf(Timy::TaskFile.taskdir)

taskmap.each_pair do |key,value|
  filepath = Timy::TaskFile.taskpath(value)
  Timy::TaskFile.new(filepath).write(value)
end

