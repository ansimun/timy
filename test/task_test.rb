# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'teatime/task'

class TaskTest < Test::Unit::TestCase
  def test_initialize
    task = TeaTime::Task.new("hallo")
    assert_equal("hallo", task.name)
    assert_nil(task.start_time)
    assert_nil(task.end_time)
    assert_nil(task.elapsed_hours)
    assert(!task.active?)
  end
  
  def test_initialize2
    task = TeaTime::Task.new("hallo", "2010-01-01 00:40:09")
    assert_equal(DateTime.parse("2010-01-01 00:40:09"), task.start_time)
    assert_nil(task.end_time)
    assert(task.active?)
  end
  
  def test_initialize3
    task = TeaTime::Task.new("welt", nil, "2000-01-01 08:31:00")
    assert_nil(task.start_time)
    assert_equal(DateTime.parse("2000-01-01 08:31:00"), task.end_time)
    assert(!task.active?)
    assert_nil(task.elapsed_hours)
  end
  
  def test_initialize4
    task = TeaTime::Task.new("hallo welt", "0000-01-01 00:00:00", "0000-01-02 00:00:00")
    assert(!task.active?)
    assert_equal(24, task.elapsed_hours)
  end
  
  def test_start
    task = TeaTime::Task.new("hallo")
    task.start
    sleep(1)
    assert(task.active?)
    assert(task.elapsed_hours > 0)
  end
  
  def test_end
    task = TeaTime::Task.new("welt")
    task.start
    sleep(1)
    task.stop
    assert(!task.active?)
    assert(task.elapsed_hours > 0)
  end
end
