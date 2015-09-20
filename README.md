**timy** - Time tracker for the shell

You can run the ruby script by using the given shell script timy.sh. Call `chmod u+x timy.sh` to make the script executable before. On Windows you can use the gem ocra to build an executable by calling `ocra lib/main.rb --output timy.exe`. 

Have fun!

```shellscript
Usage:  ./timy.sh [OPTIONS]
        
OPTIONS:
--new TASKNAME
        Adds a new task with the given taskname
--start PATTERN
        Starts the first task matching the given pattern
--stop
        Stops the active task
--print
        Prints a tabular overview of all tasks (previous month, current month, today). (Default)
--print-days
        Prints a tabular overview of all tasks per day
--filter PATTERN
        Filters the printed tasks by the given pattern.

```
  
