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

require_relative "arguments"
require_relative "timy"
require_relative "timy/taskfile"
require_relative "timy/tracker"

args = Arguments.new(ARGV)

taskdir = Timy::TaskFile.taskdir
unless (Dir.exist?(taskdir))
  Dir.mkdir(taskdir)
end

tasks = Array.new
Dir.new(taskdir).each do |filename|
  abs_filename = File.join(Timy::TaskFile.taskdir, filename)
  if (File.file?(abs_filename))
    taskfile = Timy::TaskFile.new(abs_filename)
    tasks.push(taskfile.read())
  end
end

tracker = Timy::Tracker.new(tasks)

if (args.command == Arguments::HELP)
  puts args.banner
elsif (args.command == Arguments::LIST)
  Timy.list(tracker)
elsif (args.command == Arguments::NEW)
  Timy.new(tracker, args.taskname)
elsif (args.command == Arguments::START)
  Timy.start(tracker, args.taskname)
elsif (args.command == Arguments::STOP)
  Timy.stop(tracker)
end

tracker.tasks.each do |task|
  filepath = Timy::TaskFile.taskpath(task)
  Timy::TaskFile.new(filepath).write(task)
end
