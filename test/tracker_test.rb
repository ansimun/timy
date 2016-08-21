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
require 'timy/tracker'

class TrackerTest < Test::Unit::TestCase

  def test_new_add_and_start_task()
    tasks = [Timy::Task.new("hula"),
      Timy::Task.new("bula"),
      Timy::Task.new("test"),
      Timy::Task.new("testneverstopped"),
      Timy::Task.new("testneverstarted")]
    tracker = Timy::Tracker.new(tasks)
    tracker.start_new("testtest")
    assert_equal("testtest", tracker.active.name)
  end

  def test_new_start_existing_task()
    tasks = [Timy::Task.new("hula"),
      Timy::Task.new("bula"),
      Timy::Task.new("test"),
      Timy::Task.new("testneverstopped"),
      Timy::Task.new("testneverstarted")]
    tracker = Timy::Tracker.new(tasks)
    tracker.start_new("bula")
    assert_equal("bula", tracker.active.name)
  end

  def test_start()
    task = Timy::Task.new("testtest")
    tracker = Timy::Tracker.new([task])
    tracker.start("TT")
    assert(tracker.tasks.first.active?)
  end

  def test_stop()
    task = Timy::Task.new("test")
    tracker = Timy::Tracker.new([task])
    tracker.start("test")
    tracker.stop
    assert(!tracker.tasks.first.active?)
  end

  def test_get_first_started()
    initial_tasks = [Timy::Task.new("never_started")]
    tracker = Timy::Tracker.new(initial_tasks)
    tracker.start_new("first")
    sleep(0.2)
    tracker.start_new("second")
    sleep(0.2)
    tracker.start_new("third")
    assert_equal("first", tracker.first_started.name)
  end

  def test_get_laststopped()
    tasks = [Timy::Task.new("hula"),
      Timy::Task.new("bula"),
      Timy::Task.new("test"),
      Timy::Task.new("testneverstopped"),
      Timy::Task.new("testneverstarted")]
    tracker = Timy::Tracker.new(tasks)
    tracker.start("hula")
    sleep(0.1)
    tracker.start("test")
    sleep(0.1)
    tracker.start("bula")
    sleep(0.1)
    tracker.stop
    tracker.start("testneverstopped")
    assert_equal("bula", tracker.last_stopped.name)
  end

  def test_get_lastactive_when_unstopped_task_available()
    tasks = [Timy::Task.new("hula"),
      Timy::Task.new("bula"),
      Timy::Task.new("test"),
      Timy::Task.new("testneverstopped"),
      Timy::Task.new("testneverstarted")]
    tracker = Timy::Tracker.new(tasks)
    tracker.start("hula")
    sleep(0.1)
    tracker.start("test")
    sleep(0.1)
    tracker.start("bula")
    sleep(0.1)
    tracker.stop
    tracker.start("testneverstopped")
    assert_equal("testneverstopped", tracker.last_active.name)
  end

  def test_get_lastactive_when_only_stopped_available()
    tasks = [Timy::Task.new("hula"),
      Timy::Task.new("bula"),
      Timy::Task.new("test"),
      Timy::Task.new("testneverstarted")]
    tracker = Timy::Tracker.new(tasks)
    tracker.start("test")
    sleep(0.1)
    tracker.start("bula")
    sleep(0.1)
    tracker.start("hula")
    sleep(0.1)
    tracker.stop
    assert_equal("hula", tracker.last_active.name)
  end

end
