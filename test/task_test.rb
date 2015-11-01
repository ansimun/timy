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

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'timy/task'

class TaskTest < Test::Unit::TestCase
  def test_initialize
    task = Timy::Task.new("hallo")
    assert_equal("hallo", task.name)
    assert_nil(task.start_time)
    assert_nil(task.end_time)
    assert_nil(task.elapsed_hours)
    assert(!task.active?)
  end
  
  def test_initialize2
    task = Timy::Task.new("hallo", "2010-01-01 00:40:09")
    assert_equal(DateTime.parse("2010-01-01 00:40:09"), task.start_time)
    assert_nil(task.end_time)
    assert(task.active?)
  end
  
  def test_initialize3
    task = Timy::Task.new("welt", nil, "2000-01-01 08:31:00")
    assert_nil(task.start_time)
    assert_equal(DateTime.parse("2000-01-01 08:31:00"), task.end_time)
    assert(!task.active?)
    assert_nil(task.elapsed_hours)
  end
  
  def test_initialize4
    task = Timy::Task.new("hallo welt", "0000-01-01 00:00:00", "0000-01-02 00:00:00")
    assert(!task.active?)
    assert_equal(24, task.elapsed_hours)
  end
  
  def test_start
    task = Timy::Task.new("hallo")
    task.start
    sleep(1)
    assert(task.active?)
    assert(task.elapsed_hours > 0)
  end
  
  def test_end
    task = Timy::Task.new("welt")
    task.start
    sleep(1)
    task.stop
    assert(!task.active?)
    assert(task.elapsed_hours > 0)
  end
end
