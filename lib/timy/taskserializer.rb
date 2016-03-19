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

require "json"

module Timy
  class TaskSerializer
    
    attr_reader :task, :pretty

    def initialize(task, pretty=false)
      raise ArgumentError.new("argument nil") if task.nil?
      @task = task
      @pretty = pretty
    end

    def serialize()
      result = {"name" => @task.name, "uid" => @task.uid, 
                "tags" => @task.tags, "tracker" => times_to_json_compatible_array}

      return JSON.generate(result)
    end

    private

    def times_to_json_compatible_array()
      result = Array.new
      @task.times.each do |timerange|
        result.push(timerange_to_json_compatible_hash(timerange))
      end
      return result
    end

    def timerange_to_json_compatible_hash(timerange)
      result = { "start" => timerange.start, "stop" => timerange.stop }
    end

  end
end

