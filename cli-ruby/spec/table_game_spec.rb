require "helper"
require_relative '../lib/table_game'

describe TableGame do
  describe "Execute game" do
    before do
      @table_game = TableGame.new([5,5])
    end

    it "ignore commands before PLACE" do
      commands = <<~HEREDOC
        MOVE
        RIGHT
        RIGHT
        RIGHT
        LEFT
        RIGHT
        PLACE 4,4,NORTH
        MOVE
        RIGHT
        REPORT
      HEREDOC

      expect do
        @table_game.execute(commands)
      end.to output('4,3,EAST').to_stdout
    end

    it "ignore commands when position of PLACE command is invalid" do
      commands = <<~HEREDOC
        PLACE 5,5,NORTH
        MOVE
        RIGHT
        REPORT
      HEREDOC

      expect do
        @table_game.execute(commands)
      end.to_not output.to_stdout
    end

    it "do not fail when commands are not given" do
      commands = nil

      expect do
        @table_game.execute(commands)
      end.to_not output.to_stdout
    end

    it "ignore commands when facing of PLACE command is invalid" do
      commands = <<~HEREDOC
        PLACE 4,4,NORTH2
        MOVE
        RIGHT
        REPORT
      HEREDOC

      expect do
        @table_game.execute(commands)
      end.to_not output.to_stdout
    end

    it "ignore commands when having different case" do
      commands = <<~HEREDOC
        PLaCE 4,4,NoRTH
        MoVE
        RIGhT
        REPoRT
      HEREDOC

      expect do
        @table_game.execute(commands)
      end.to output('4,3,EAST').to_stdout
    end

    it "run multiples PLACE commands" do
      commands = <<~HEREDOC
        PLACE 4,4,NORTH
        MOVE
        PLACE 2,2,NORTH
        RIGHT
        REPORT
      HEREDOC

      expect do
        @table_game.execute(commands)
      end.to output('2,2,EAST').to_stdout
    end

    it "ignore multiples invalids PLACE commands" do
      commands = <<~HEREDOC
        PLACE 4,4,NORTH
        MOVE
        PLACE 2,2,NORTH
        PLACE 2,10,NORTH
        RIGHT
        REPORT
        PLACE 8,2,NORTH
      HEREDOC

      expect do
        @table_game.execute(commands)
      end.to output('2,2,EAST').to_stdout
    end

    it "ignore firsts invalids PLACE commands" do
      commands = <<~HEREDOC
        PLACE 32,10,NORTH
        PLACE 2,10,NORTH
        PLACE 4,4,NORTH
        MOVE
        PLACE 2,2,NORTH
        PLACE 2,10,NORTH
        RIGHT
        REPORT
        PLACE 8,2,NORTH
      HEREDOC

      expect do
        @table_game.execute(commands)
      end.to output('2,2,EAST').to_stdout
    end

    it "ignore firsts invalids PLACE commands" do
      commands = <<~HEREDOC
        PLACE 32,10,NORTH
        PLACE 2,10,NORTH
        PLACE 4,4,NORTH
        MO3VE
        PLACE 2,2,NORTH
        PLACE 2,10,NORTH
        RIGHtT
        RE3PORT
        PLACE 8,2,NORTH
        REPORT
      HEREDOC

      expect do
        @table_game.execute(commands)
      end.to output('2,2,NORTH').to_stdout
    end
  end
end
