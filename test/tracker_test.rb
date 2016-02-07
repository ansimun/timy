# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'timy/tracker'
require "timy/legacytracker"

class TrackerTest < Test::Unit::TestCase
  def test_first_if_count_greater_1
    tracker = Timy::LegacyTracker.new
    tracker.new_task("test_task1")
    tracker.stop_task
    tracker.new_task("test_task2")
    tracker.stop_task
    assert_equal("test_task1", tracker.first_task.name)
  end
  
  def test_first_if_count_equals_1
    tracker = Timy::LegacyTracker.new
    tracker.new_task("test1")
    tracker.stop_task
    assert_equal("test1", tracker.first_task.name)
  end
  
  def test_first_if_emtpy
    tracker = Timy::LegacyTracker.new
    assert_equal(nil, tracker.first_task)
  end
  
end
