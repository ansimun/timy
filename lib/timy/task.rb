require "date"

module Timy
  class Task
    attr_reader :name, :start_time, :end_time
    
    def initialize(name, start_time = nil, end_time = nil)
      raise "Invalid argument" if name.nil?
      @name=name
      @start_time = parse_time(start_time) unless start_time.nil?
      @end_time = parse_time(end_time) unless end_time.nil?
    end
    
    def start()
      @start_time = DateTime.now
      @end_time = nil
    end
    
    def stop()
      @end_time = DateTime.now if active?
    end
    
    def elapsed_hours()
      if (@start_time.nil?)
        return nil
      elsif (@end_time.nil?)
        return (DateTime.now - @start_time).to_f * 24
      elsif (@end_time < @start_time)
        return nil
      end
      
      return (@end_time - @start_time).to_f * 24
    end
    
    def active?()
      return (!@start_time.nil? && @end_time.nil?)
    end

    private
    
    def parse_time(time)
      result = nil
      if (time.kind_of?(String))
        result = DateTime.parse(time)
        result = nil if result == DateTime.new(1) # was formerly used instead of nil
      elsif (time.kind_of?(DateTime))
        result = time
      else
        raise "Type mismatch - type of DateTime or String expected"
      end
      
      return result
    end
    
  end
end
