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
#    License along with this library; if not, write to the Free Software
#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
#    USA
#    

require "securerandom"

module Timy
  class Task
    attr_reader :name, :uid, :tags
    
    @times
    
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
      raise Error.new("implement me")
    end
    
    def stop()
      raise Error.new("implement me")
    end
    
    def active?()
      raise Error.new("implement me")
    end
    
    def elapsed_hours()
      raise Error.new("implement me")
    end
  end
end
