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
require 'timy/taskserializer'

class TaskTest < Test::Unit::TestCase
  def test_attribute_task_as_given_by_new()
    taskserializer = Timy::TaskSerializer.new(Timy::Task.new("hula"))
    assert_not_nil(taskserializer.task)
    assert_equal("hula", taskserializer.task.name)
  end

  def test_serialize_empty_task()
    task = Timy::Task.new("hello")
    taskserializer = Timy::TaskSerializer.new(task)
    expected_json = "{\"name\":\"#{task.name}\",\"uid\":\"#{task.uid}\",\"tags\":[],\"times\":[]}"
    assert_equal(expected_json, taskserializer.serialize)
  end

  def test_serialize_started_task()
    task = Timy::Task.new("halloballo")
    task.start
    taskserializer = Timy::TaskSerializer.new(task)
    expected_json = "{\"name\":\"#{task.name}\",\"uid\":\"#{task.uid}\",\"tags\":[],\"times\":[{\"start\":\"#{task.times[0].start}\",\"stop\":null}]}"
    assert_equal(expected_json, taskserializer.serialize)
  end

  def test_serialize_stopped_task()
    task = Timy::Task.new("halloballo")
    task.start
    sleep(0.1)
    task.stop
    taskserializer = Timy::TaskSerializer.new(task)
    expected_json = "{\"name\":\"#{task.name}\",\"uid\":\"#{task.uid}\",\"tags\":[],\"times\":[{\"start\":\"#{task.times[0].start}\",\"stop\":\"#{task.times[0].stop}\"}]}"
    assert_equal(expected_json, taskserializer.serialize)
  end

  def test_serialize_pretty_empty_task()
    task = Timy::Task.new("hello")
    taskserializer = Timy::TaskSerializer.new(task)
    expected_json = %({
  "name" : "#{task.name}",
  "uid" : "#{task.uid}",
  "tags" : [

  ],
  "times" : [

  ]
})
    assert_equal(expected_json, taskserializer.serialize_pretty)
  end

  def test_serialize_pretty_with_times()
    task = Timy::Task.new("hello")
    taskserializer = Timy::TaskSerializer.new(task)
    task.start
    sleep(0.1)
    task.stop
    expected_json = %({
  "name" : "#{task.name}",
  "uid" : "#{task.uid}",
  "tags" : [

  ],
  "times" : [
    {
      "start" : "#{task.times[0].start}",
      "stop" : "#{task.times[0].stop}"
    }
  ]
})
    assert_equal(expected_json, taskserializer.serialize_pretty)
  end
end
