# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'teatime'
require 'teatime/timetable'

class TeaTimeTest < Test::Unit::TestCase
  def test_read
    timetable = TeaTime.read("test/test.csv")
    assert_equal(timetable.count, 49, "count of read tasks != 49 (#{timetable.count})")
  end
  
  def test_write
    timetable = TeaTime::TimeTable.new("hallo;2012-10-03 08:00:00;2012-10-03 12:00:00")
    timetable.add(TeaTime::Task.new("second task"))
    timetable.add(TeaTime::Task.new("third task"))
    TeaTime.write("test/test2.csv", timetable)
    
    timetable = TeaTime::read("test/test2.csv")
    assert_equal(3, timetable.count)
    assert_equal("third task", timetable.last.name)
    assert_nil(timetable.last.start_time)
    assert_nil(timetable.last.end_time)
  end
  
end
