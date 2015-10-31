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
#    License along with this library; if not, write to the Free Software
#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
#    USA
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
end
