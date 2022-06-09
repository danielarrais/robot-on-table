PLACE_COMMAND_NAME = 'PLACE'
PLACE_COMMAND_REGEX = /(\bplace\b) \d+,\d+,((\bnorth\b)|(\beast\b)|(\bsouth\b)|(\bwest\b))/
OTHER_COMMANDS_REGEX = /(\bmove\b)|(\bleft\b)|(\bright\b)|(\breport\b)/

class InputCommandsProcessor
  def initialize(input)
    @input = input
  end

  def process
    return [] if @input.nil? || @input.empty?

    commands = @input.split(/(\n)/)
    valid_commands = filter_valid_commands(commands)
    executable_commands = filter_commands_after_place(valid_commands)

    build_commands(executable_commands)
  end

  private

  def filter_valid_commands(commands)
    return [] if (commands.nil? || commands.empty?)

    commands.select { |command| valid_command?(command) }
  end

  def filter_commands_after_place(commands)
    commands_filtered = []

    commands.each do |command|
      if !commands_filtered.empty? || command.upcase.include?(PLACE_COMMAND_NAME)
        commands_filtered.push(command)
      end
    end

    commands_filtered
  end

  def valid_command?(command)
    return false if command.nil? || command.empty?

    if command.upcase.include?(PLACE_COMMAND_NAME)
      command.downcase.match?(PLACE_COMMAND_REGEX)
    else
      command.downcase.match?(OTHER_COMMANDS_REGEX)
    end
  end

  def build_commands(valid_commands)
    return [] if valid_commands.nil? || valid_commands.empty?
    commands = []
    valid_commands.each do |command_str|
      if command_str.upcase.include?(PLACE_COMMAND_NAME)
        command = build_place_command(command_str)
      else
        command = build_simple_command(command_str)
      end
      commands.push(command)
    end

    commands
  end

  def build_place_command(command)
    parts_of_command = command.split(' ')
    name = parts_of_command[0]
    params = parts_of_command[1].split(',')

    {
      name: name.to_sym,
      params: {
        x: params[0].to_i,
        y: params[1].to_i,
        facing: params[2].downcase.to_sym
      }
    }
  end

  def build_simple_command(command_str)
    {
      name: command_str.to_sym
    }
  end
end
