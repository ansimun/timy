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

require "date"
require_relative "timy/legacytracker"
require_relative "timy/textreport"

module Timy
  def self.new(tracker, taskname)
    tracker.start_new(taskname)
    active_task = tracker.active
    puts "> Start new task '#{active_task.name}'" unless active_task.nil?
  end

  def self.start(tracker, taskname_pattern)
    tracker.start(taskname_pattern)
    active_task = tracker.active
    puts "> Start task '#{active_task.name}'" unless active_task.nil?
  end

  def self.stop(tracker)
    tracker.stop
    last_stopped_task = tracker.last_stopped
    puts "> Stop task '#{last_stopped_task.name}'" unless last_stopped_task.nil?
  end

  def self.list(tracker)
    tracker.tasks.each do |task|
      puts "Task: #{task.name} - #{task.uid.split('-').first}#{"*" if task.active?}"
      puts "\tElapsed Hours: #{task.elapsed_hours.round(2)}"
    end
  end
end
