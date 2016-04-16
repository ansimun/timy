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

module Timy
  class Tracker
    attr_reader :tasks

    def initialize(tasks=nil)
      raise ArgumentError.new("Type mismatch, expected type of Array") unless
        tasks.nil? || tasks.kind_of?(Array)

      active_tasks = (tasks.nil?)? Array.new : tasks.select{|t| t.active?}
      if (active_tasks.length > 1)
        raise ArgumentError.new("More than 1 started task (#{active_tasks.map{|t|t.name}.join(",")})")
      end

      @tasks = Array.new
      @tasks = tasks unless tasks.nil?
    end

    def new_task(name)
      raise ArgumentError.new("Argument is nil or empty") if name.nil? || name.empty?
      raise ArgumentError.new("Task with given name already existing") if @tasks.any?{|t| t.name == name}

      @tasks.push(Task.new(name))
    end

    def start(pattern)
      task = @tasks.select{|t| /#{pattern}/i === t.name}.first
      unless (task.nil?)
        task.start
      end
    end

    def stop()
      task = @tasks.select{|t| t.active?}.first
      unless (task.nil?)
        task.stop
      end
    end
  end
end
