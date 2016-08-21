#
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

require_relative "taskparser"
require_relative "taskserializer"

module Timy
  class TaskFile
    attr_reader :filepath

    def initialize(filepath)
      raise ArgumentError.new("argument filepath is nil or empty") if filepath.nil? || filepath.to_s.empty?

      @filepath = filepath
    end

    def read()
      raise IOError.new("file not existing") unless File.exist?(@filepath)

      TaskParser.new(IO.read(@filepath, :encoding => "utf-8")).parse
    end

    def write(task)
      raise ArgumentError.new("argument task is nil") if task.nil?

      unless (Dir.exist?(TaskFile.taskdir))
        Dir.mkdir(TaskFile.taskdir)
      end

      IO.write(@filepath,TaskSerializer.new(task).serialize_pretty, :encoding => "utf-8")
    end

    def self.taskpath(task)
      return File.join(taskdir, filename(task))
    end

    def self.taskdir()
      File.join(Dir.home, "timy")
    end

    def self.filename(task)
      result = "task_#{task.uid.split('-').first}.json"
    end

  end
end
