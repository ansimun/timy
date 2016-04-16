# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'timy/tracker'

class TrackerTest < Test::Unit::TestCase
  def test_initialize_avoids_2_active_tasks()
    assert_raise do
      tasks = Array.new
      tasks << Timy::Task.new("hula")
      tasks << Timy::Task.new("bula")
      tasks.each {|t| t.start}
      tracker = Timy::Tracker.new(tasks)
    end
  end

  def test_new_task()
    tracker = Timy::Tracker.new
    tracker.new_task("hula")
    assert_equal(1, tracker.tasks.length)
    assert_equal("hula", tracker.tasks.first.name)
  end

  def test_new_task_avoid_doubles()
    assert_raise do
      tracker = Timy::Tracker.new
      tracker.new_task("task1")
      tracker.new_task("task2")
      tracker.new_task("task1")
    end
  end

  def test_start()
    tracker = Timy::Tracker.new
    tracker.new_task("testtest")
    tracker.start("TT")
    assert(tracker.tasks.first.active?)
  end

  def test_stop()
    tracker = Timy::Tracker.new
    tracker.new_task("test")
    tracker.start("test")
    tracker.stop
    assert(!tracker.tasks.first.active?)
  end

end
