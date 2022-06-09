require_relative '../lib/input_commands_processor'

describe InputCommandsProcessor do
  describe "Process commands" do
    it "process all valids commands" do
      commands = <<~HEREDOC
        PLACE 4,4,NORTH
        MOVE
        RIGHT
        REPORT
      HEREDOC

      @commands = InputCommandsProcessor.new(commands).process

      expect(@commands.length).to equal(4)
      expect(@commands[0]).to include({ name: :PLACE, params: { x: 4, y: 4, facing: 'NORTH'.downcase.to_sym } })
      expect(@commands[1]).to include({ name: :MOVE })
      expect(@commands[2]).to include({ name: :RIGHT })
      expect(@commands[3]).to include({ name: :REPORT })
    end

    it "not process all commands when PLACE command is not valid" do
      commands = <<~HEREDOC
        PLACE 4,4,NORTH3
      HEREDOC

      @commands = InputCommandsProcessor.new(commands).process

      expect(@commands.length).to equal(0)
    end

    it "not process commands before PLACE command" do
      commands = <<~HEREDOC
        MOVE
        RIGHT
        REPORT
        PLACE 4,4,NORTH
        MOVE
        RIGHT
        REPORT
      HEREDOC

      @commands = InputCommandsProcessor.new(commands).process

      expect(@commands.length).to equal(4)
      expect(@commands[0]).to include({ name: :PLACE, params: { x: 4, y: 4, facing: 'NORTH'.downcase.to_sym } })
      expect(@commands[1]).to include({ name: :MOVE })
      expect(@commands[2]).to include({ name: :RIGHT })
      expect(@commands[3]).to include({ name: :REPORT })
    end

    it "not process invalids commands" do
      commands = <<~HEREDOC
        MOVEd
        MOVED
        RIgGHT
        REPOjRT
        PLACE 4,4,NO3RTH
      HEREDOC

      @commands = InputCommandsProcessor.new(commands).process

      expect(@commands.length).to equal(0)
    end
  end
end
