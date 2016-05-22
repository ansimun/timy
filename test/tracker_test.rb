# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'timy/tracker'

class TrackerTest < Test::Unit::TestCase

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
