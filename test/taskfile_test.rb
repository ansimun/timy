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
#    License along with this library.
#    

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'tempfile'
require 'timy/taskfile'

class TaskTest < Test::Unit::TestCase
  def test_filename_gets_correct_name()
    task = Timy::Task.new("hula", "ba4ab614-f97c-11e5-9ce9-5e5517507c66")
    assert_equal("task_ba4ab614.json", Timy::TaskFile.filename(task))
  end

  def test_attr_filepath_as_given_by_initialize()
    filepath = "/path/to/file"
    taskfile = Timy::TaskFile.new(filepath)
    assert_equal(filepath, taskfile.filepath)
  end

  def test_initialize_throws_when_argument_nil()
    assert_raise(ArgumentError) do
      Timy::TaskFile.new(nil)
    end
  end

  def test_read_returns_task()
    task = Timy::TaskFile.new("#{File.dirname(__FILE__)}/task_file.json").read
    assert_not_nil(task)
    assert_equal("change model", task.name)
    assert_equal("e9f73g4", task.uid)
    assert_equal(2, task.tags.length)
    assert_equal(3, task.times.length)
  end

  def test_write_saves_given_task()
    task = Timy::Task.new("testtest")
    tempfilename = Dir::Tmpname.make_tmpname("testtest", ".json")
    begin
      Timy::TaskFile.new(tempfilename).write(task)
      content = IO.read(tempfilename, :encoding => "utf-8")
      expected = %Q({
  "name" : "testtest",
  "uid" : "#{task.uid}",
  "tags" : [

  ],
  "times" : [

  ]
})
      assert_equal(expected, content)
    ensure
      if (File.exist?(tempfilename))
        File.delete(tempfilename)
      end
    end

  end
end

