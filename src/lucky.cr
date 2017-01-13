require "colorize"
require "./lucky_cli"
require "./generators/*"
require "./init_questions"

args = ARGV.join(" ")

def arrow
  "▸"
end

def red_arrow
  arrow.colorize(:red)
end

def green_arrow
  arrow.colorize(:green)
end

if File.exists?("./tasks.cr")
  Process.run "crystal run ./tasks.cr -- #{args}",
    shell: true,
    output: true,
    error: true
elsif ARGV.first? == "init"
  LuckyCli::InitQuestions.run
else
  puts <<-MISSING_TASKS_FILE

  #{"Missing tasks.cr file".colorize(:red)}

  Try this...

    #{red_arrow} Change to the directory with the task.cr file,
      usually your project root
    #{red_arrow} If this is a new project, run #{"lucky init".colorize(:green)} to
      create a default tasks.cr file

  MISSING_TASKS_FILE
end
