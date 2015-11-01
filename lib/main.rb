# 
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

require "fileutils"
require_relative "timy"
require_relative "arguments"

args = Arguments.new(ARGV)

filename = File.join(Dir.home,"Times.txt")
FileUtils.touch(filename) unless File.exist?(filename)

if (args.command == Arguments::HELP)
  puts args.banner
elsif (args.command == Arguments::LIST)
  Timy.list(filename)
elsif (args.command == Arguments::NEW)
  Timy.new(filename, args.taskname)
elsif (args.command == Arguments::START)
  Timy.start(filename, args.taskname)
elsif (args.command == Arguments::STOP)
  Timy.stop(filename)
elsif (args.command == Arguments::PRINT)
  Timy.print(filename, args.expression)
end