require_relative 'lib/entrypoints/command'
require_relative 'lib/entrypoints/file'

option, file = ARGV
if (option == '-f' || option == '--file') && !file.nil?
  File.run(file)
else
  Command.run
end


