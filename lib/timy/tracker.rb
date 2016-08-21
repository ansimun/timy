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

require_relative "task"

module Timy
  class Tracker
    attr_reader :tasks

    def initialize(tasks)
      raise ArgumentError.new("Type mismatch, expected type of Array") unless
        tasks.nil? || tasks.kind_of?(Array)

      @tasks = tasks
    end

    def start(pattern)
      task = matching(pattern)
      unless (task.nil?)
        stop
        task.start
      end
    end

    def start_new(name)
      task = @tasks.select{|t| t.name == name}.first
      task = Task.new(name) if task.nil?
      @tasks.push(task)
      stop
      task.start
    end

    def start_last()
      stop
      task = last_stopped
      task.start unless task.nil?
    end

    def stop()
      task = active
      task.stop unless task.nil?
    end

    def last_active()
      active || last_stopped
    end

    def active()
      @tasks.select{|t| t.active?}.first
    end

    def active_in_timespan(startTime, stopTime)
    end

    def first_started()
      @tasks.select{|t| t.times.length > 0}.
        sort{|a,b| a.times.first.start <=> b.times.first.start}.first
    end

    def last_stopped()
      @tasks.select{|t| t.times.length > 0 && !t.active?}.
        sort{|a,b| a.times.last.stop <=> b.times.last.stop}.last
    end

    private

    def matching(pattern)
      @tasks.select{|t| /#{pattern}/i === t.name}.first
    end
  end
end
