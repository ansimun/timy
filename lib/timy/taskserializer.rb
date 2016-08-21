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

require "json"

module Timy
  class TaskSerializer

    attr_reader :task

    def initialize(task)
      raise ArgumentError.new("argument nil") if task.nil?
      @task = task
    end

    def serialize()
      return JSON.generate(build_task_hash)
    end

    def serialize_pretty()
      return JSON.pretty_generate(build_task_hash, :indent => "  ", :space => " ", :space_before => " ")
    end

    private

    def build_task_hash()
      return {"name" => @task.name, "uid" => @task.uid, "tags" => @task.tags, "times" => build_times_array}
    end

    def build_times_array()
      result = Array.new
      @task.times.each do |timerange|
        result.push(build_timerange_hash(timerange))
      end
      return result
    end

    def build_timerange_hash(timerange)
      result = { "start" => timerange.start, "stop" => timerange.stop }
    end

  end
end
