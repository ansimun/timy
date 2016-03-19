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

require "securerandom"
require "date"

module Timy
  TimeRange = Struct.new(:start,:stop)
  
  class Task
    attr_reader :name, :uid, :tags, :times
    
    def initialize(name)
      raise ArgumentError.new("argument nil") if name.nil? 
      raise ArgumentError.new("argument 'name' is empty") if name.to_s.empty?

      @name = name.to_s
      @uid = SecureRandom.uuid
      @uid.freeze
      @tags = Array.new
      @times = Array.new
    end
    
    def start()
      stop
      @times.push(TimeRange.new(DateTime.now.new_offset, nil))
    end
    
    def stop()
      if !@times.empty? && @times.last.stop.nil?
        @times.last.stop = DateTime.now.new_offset
      end
    end
    
    def active?()
      !@times.empty? && @times.last.stop.nil?
    end
    
    def elapsed_hours()
      hours = 0
      @times.each do |time_range|
        start = time_range.start
        stop = time_range.stop unless time_range.stop.nil?
        stop = DateTime.now.new_offset if time_range.stop.nil?
        hours = hours + (stop - start).to_f * 24
      end
      return hours
    end
  end
end
