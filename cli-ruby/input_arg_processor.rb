PLACE_COMMAND_NAME = 'PLACE'
PLACE_COMMAND_REGEX = /(\bplace\b) \d+,\d+,((\bnorth\b)|(\beast\b)|(\bsouth\b)|(\bwest\b))+/

class InputArgProcessor
  def initialize(input)
    @input = input
  end

  def process
    return [] if @input.nil? || @input.empty?

    commands_str = @input.split('\n')
    valid_commands_str = filter_valids_commands(commands_str)

    build_commands(valid_commands_str)
  end

  private

  def filter_valids_commands(commands)
    return [] if (commands.nil? || commands.empty?)

    valid_commands = commands.select { |command| !command.empty? }
    place_command_index = valid_commands.index do |command|
      command.downcase.match?(PLACE_COMMAND_REGEX)
    end

    return [] if (place_command_index.nil?)

    commands[place_command_index, commands.length]
  end

  def build_commands(valid_commands_str)
    place_command_str = valid_commands_str.shift
    place_command = build_place_command(place_command_str)

    return [] if (place_command.nil?)

    commands = []
    commands.push(place_command)

    valid_commands_str.each do |command_str|
      command = build_simple_command(command_str)
      commands.push(command)
    end

    commands
  end

  def build_place_command(place_command_str)
    return nil if (place_command_str.nil? || place_command_str.empty?)
    return nil if (!place_command_str.include?(' '))

    parts_of_place_command = place_command_str.split(' ')
    command_name = parts_of_place_command[0]
    params = parts_of_place_command[1].split(',')

    {
      name: command_name.to_sym,
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
