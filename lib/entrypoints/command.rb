require_relative '../simulator'

class Command
  class << self
    def run
      start_message

      run_simulator
    end

    private

    def start_message
      puts "Toy Robot Simulator\n\n"
      puts instruction
      print prompt
    end

    def prompt
      '>'
    end

    def instruction
      instruction = [
          "Please input the robot's name with colon following commands to start.",
          'Example:',
          'PLACE X,Y,F',
          'MOVE',
          'LEFT',
          'RIGHT',
          'REPORT',
          "'help' to read the instruction and 'quit' or 'exit' to exit."
      ]
      instruction.join("\n")
    end

    def empty_input_message
      'Empty command, please input again'
    end

    def run_simulator
      @simulator = Simulator.new

      while input = gets.chomp
        input = input.strip.upcase
        # Exit the loop when input is 'quit' or 'exit'
        break if input == 'QUIT' || input == 'EXIT'

        # Prompt some instruction if input is empty
        if input == ''
          puts empty_input_message
          print prompt
          next
        end

        # Prompt help instruction
        puts instruction if input == 'HELP'

        # Execute input command and check if the input is valid.
        # If the input is valid, the simulator will return the output otherwise it will print out the error instruction
        begin
          output = @simulator.run(input)
        rescue StandardError => e
          puts e
          print prompt
          next
        end

        puts output if output
        print prompt
      end
    end
  end
end
