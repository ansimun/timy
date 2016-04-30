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

    def initialize(tasks)
      raise ArgumentError.new("Type mismatch, expected type of Array") unless
        tasks.nil? || tasks.kind_of?(Array)

      @tasks = tasks
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
