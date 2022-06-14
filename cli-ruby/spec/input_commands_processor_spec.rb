require "helper"
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
      expect(@commands[0]).to include({ name: :PLACE, params: { x: 4, y: 4, facing: 'NORTH'.to_sym } })
      expect(@commands[1]).to include({ name: :MOVE })
      expect(@commands[2]).to include({ name: :RIGHT })
      expect(@commands[3]).to include({ name: :REPORT })
    end

    it "not process commands when the PLACE command not contains valid structure" do
      commands = <<~HEREDOC
        PLACE 4,4,NORTH3
      HEREDOC

      @commands = InputCommandsProcessor.new(commands).process

      expect(@commands.length).to equal(0)
    end

    it "not process commands with invalid structure" do
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


    it "process commands when having different case" do
      commands = <<~HEREDOC
        PLaCE 4,4,NoRTH
        MoVE
        RIGhT
        REPoRT
      HEREDOC

      @commands = InputCommandsProcessor.new(commands).process

      expect(@commands.length).to equal(4)
    end
  end
end
