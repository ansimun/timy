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

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'timy/task'

class TaskTest < Test::Unit::TestCase
  def test_raise_argumenterror_if_name_nil
    assert_raise do
      Timy::Task.new(nil)
    end
  end
  def test_raise_argumenterror_if_name_empty
    assert_raise do
      Timy::Task.new("")
    end
  end
  def test_name_set_as_given_by_string
    task = Timy::Task.new("bugfix")
    assert_equal("bugfix", task.name)
  end
  def test_name_set_as_given_by_number
    task = Timy::Task.new(123)
    assert_equal("123", task.name)
  end
  def test_uid_initialized
    task = Timy::Task.new("issue 123")
    assert_not_nil(task.uid)
    assert(!task.uid.empty?)
  end
  def test_tags_empty
    task = Timy::Task.new("blabla")
    assert_not_nil(task.tags)
    assert_equal(0, task.tags.count)
  end
  def test_start_adds_new_times
    task = Timy::Task.new("start_test")
    task.start
    assert_equal(1,task.times.count)
    assert_nil(task.times[0].stop)
  end
  def test_start_stops_last_timing
    task = Timy::Task.new("start_test")
    task.start
    task.start
    assert_not_nil(task.times[0].stop)
  end
  def test_stop_stops_last_timing
    task = Timy::Task.new("stop_test")
    task.start
    sleep(0.1)
    task.stop
    assert_not_nil(task.times.last.stop)
    assert(task.times.last.stop > task.times.last.start)
  end
  def test_active_when_started
    task = Timy::Task.new("active_test")
    task.start
    assert(task.active?)
  end
  def test_active_when_stopped
    task = Timy::Task.new("active_test")
    task.start
    task.stop
    assert(!task.active?)
  end
  def test_elapsed_hours_when_started
    task = Timy::Task.new("elapsed_hours")
    task.start
    sleep(0.1)
    assert(task.elapsed_hours > 0)
  end
  def test_elapsed_hours_when_stopped
    task = Timy::Task.new("elapsed_hours")
    task.start
    sleep(0.1)
    task.stop
    assert(task.elapsed_hours > 0)
  end

end
