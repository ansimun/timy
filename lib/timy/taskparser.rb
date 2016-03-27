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

require "date"

module Timy

  class TaskParser

    attr_reader :json

    def initialize(json)
      raise ArgumentError.new("argument nil") if json.nil?
      @json = json
    end

    def parse()
      task_hash = JSON.parse(@json)

      name = task_hash["name"]
      raise ArgumentError.new("Expected field name but was empty or nil") if name.nil? || name.empty?

      uid = task_hash["uid"]
      raise ArgumentError.new("Expected field uid but was emtpy or nil") if uid.nil? || uid.empty?

      tags = task_hash["tags"]
      raise ArgumentError.new("Expected field tags but was nil") if tags.nil?

      times = task_hash["tracker"]
      raise ArgumentError.new("Expected field times but was nil") if times.nil?

      task = Task.new(name, uid)
      task.tags.concat(tags)
      task.times.concat(parse_times(times))

      return task
    end

    private

    def parse_times(times)
      result = Array.new

      times.each do |timerange|
        start = timerange["start"]
        raise ArgumentError.new("Expected field start but was nil or empty") if start.nil? || start.empty?

        stop = timerange["stop"]
        
        if (stop.nil?)
          result.push(TimeRange.new(DateTime.parse(start),nil))
        else
          result.push(TimeRange.new(DateTime.parse(start),DateTime.parse(stop)))
        end
      end

      return result
    end

  end

end

