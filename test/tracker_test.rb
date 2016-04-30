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

end
