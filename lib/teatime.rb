require_relative "teatime/timetable"

module TeaTime
    def self.read(filename)
      return TimeTable.new(IO.read(filename))
    end
    def self.write(filename, timetable)
      IO.write(filename, timetable.to_csv)
    end
end
