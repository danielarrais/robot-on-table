require 'simplecov'
SimpleCov.start

def build_place_command(position, facing)
  {
    name: :PLACE,
    params: {
      x: position[0],
      y: position[1],
      facing: facing
    }
  }
end

def build_simple_command(command_str)
  {
    name: command_str.to_sym
  }
end
