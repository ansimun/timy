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
require 'timy/taskparser'
require 'date'

class TaskTest < Test::Unit::TestCase

  def test_attribute_json_as_given_by_new()
    json = %Q({
  "name" : "testtest",
  "uid" : "uniqueuid",
  "tags" : [

  ],
  "times" : [

  ]
})

    parser = Timy::TaskParser.new(json)
    assert_equal(json, parser.json)
  end

  def test_parse_empty_task()
    json = %Q({
  "name" : "testtest",
  "uid" : "uniqueuid",
  "tags" : [

  ],
  "times" : [

  ]
})
    parser = Timy::TaskParser.new(json)
    task = parser.parse
    assert_equal("testtest", task.name)
    assert_equal("uniqueuid", task.uid)
    assert(task.tags.empty?)
    assert(task.times.empty?)
  end

  def test_parse_task_with_tags()
    json = %Q({
  "name" : "blabla",
  "uid" : "uniqueuid",
  "tags" : [
    "bugfix",
    "issue"
  ],
  "times" : [

  ]
})
    parser = Timy::TaskParser.new(json)
    task = parser.parse
    assert_equal(2, task.tags.length)
    assert_equal("bugfix", task.tags[0])
    assert_equal("issue", task.tags[1])
  end

  def test_parse_started_task()
    json = %Q({
  "name" : "blabla",
  "uid" : "uniqueuid",
  "tags" : [

  ],
  "times" : [
    {
      "start" : "2016-03-26T13:56:01+00:00",
      "stop" : null
    }
  ]
})
    parser = Timy::TaskParser.new(json)
    task = parser.parse
    assert_equal(1, task.times.length)
    assert_equal(DateTime.parse("2016-03-26T13:56:01+00:00"), task.times[0].start)
    assert_equal(nil, task.times[0].stop)
  end

  def test_parse_throws_when_invalid_json()
    json = %Q(name:"blabla")
    parser = Timy::TaskParser.new(json)
    assert_raise do
      parser.parse
    end
  end

  def test_parse_throws_when_missing_name()
    parser = Timy::TaskParser.new(%Q({"uid":"uniquedid", "tags":[], "times":[]}))
    assert_raise ArgumentError do
      parser.parse
    end
  end
end
