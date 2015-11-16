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
    
    def initialize()
      @tasks = load_tasks
    end
    
    def start(pattern)
      
    end
    
    def stop()
      
    end
    
    def find()
      @tasks.each do |task|
        if (yield task)
          return task
        end
      end
    end
    
    def find_active()
      
    end
    
  end
end
