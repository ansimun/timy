# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'teatime/timetable'

class TimeTableTest < Test::Unit::TestCase
  def test_initialize
    #TODO: Write test
    time_table = TeaTime::TimeTable.new("hallo;2012-10-03 08:00:00;2012-10-03 12:00:00")
    assert_equal("hallo", time_table.last.name)
    assert_equal(DateTime.parse("2012-10-03 08:00:00"), time_table.last.start_time)
    assert_equal(DateTime.parse("2012-10-03 12:00:00"), time_table.last.end_time)
  end
  
  def test_add
    #TODO: Write test
    time_table = TeaTime::TimeTable.new("hallo;2012-10-03 08:00:00;2012-10-03 12:00:00")
    time_table.add(TeaTime::Task.new("welt"))
    assert_equal(2, time_table.count)
    assert_equal("welt", time_table.last.name)
  end
end
