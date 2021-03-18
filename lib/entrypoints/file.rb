require_relative '../simulator'

class File
  class << self
    def run(file)
      begin
        robot_commands = File.readlines(file)
      rescue StandardError => e
        puts e
        return
      end

      @simulator = Simulator.new

      robot_commands.each do |command|
        begin
          output = @simulator.run(command)
        rescue StandardError => e
          puts e
          return
        end
        puts output if output
      end
    end
  end
end
