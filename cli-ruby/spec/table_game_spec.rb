require "helper"
require_relative '../lib/table_game'

describe TableGame do
  describe "Execute game" do
    before do
      @table_game = TableGame.new([5, 5])
    end

    it "ignore commands before PLACE" do
      commands = [
        build_simple_command(:MOVE),
        build_simple_command(:RIGHT),
        build_simple_command(:RIGHT),
        build_simple_command(:RIGHT),
        build_simple_command(:LEFT),
        build_simple_command(:RIGHT),
        build_place_command([4, 4], :NORTH),
        build_simple_command(:MOVE),
        build_simple_command(:RIGHT),
        build_simple_command(:REPORT),
      ]

      expect do
        @table_game.execute(commands)
      end.to output('4,3,EAST').to_stdout
    end

    it "ignore commands when position of PLACE command is invalid" do
      commands = [
        build_place_command([5, 5], :NORTH),
        build_simple_command(:MOVE),
        build_simple_command(:RIGHT),
        build_simple_command(:REPORT),
      ]

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

    it "run multiples PLACE commands" do
      commands = [
        build_place_command([4, 4], :NORTH),
        build_simple_command(:MOVE),
        build_place_command([2, 2], :NORTH),
        build_simple_command(:RIGHT),
        build_simple_command(:REPORT),
      ]

      expect do
        @table_game.execute(commands)
      end.to output('2,2,EAST').to_stdout
    end

    it "ignore multiples PLACE commands with invalids position" do
      commands = [
        build_place_command([4, 4], :NORTH),
        build_simple_command(:MOVE),
        build_place_command([2, 2], :NORTH),
        build_place_command([2, 10], :NORTH),
        build_simple_command(:RIGHT),
        build_simple_command(:REPORT),
        build_place_command([8, 2], :NORTH),
      ]

      expect do
        @table_game.execute(commands)
      end.to output('2,2,EAST').to_stdout
    end

    it "ignore multiples PLACE commands with negatives positions" do
      commands = [
        build_place_command([-4, 4], :NORTH),
        build_simple_command(:MOVE),
        build_place_command([2, 2], :NORTH),
        build_place_command([2, -10], :NORTH),
        build_simple_command(:RIGHT),
        build_simple_command(:REPORT),
        build_place_command([-8, 2], :NORTH),
      ]

      expect do
        @table_game.execute(commands)
      end.to output('2,2,EAST').to_stdout
    end

    it "ignore invalids moviments commands" do
      commands = [
        build_place_command([32, 10], :NORTH),
        build_place_command([2, 10], :NORTH),
        build_place_command([4, 4], :NORTH),
        build_simple_command(:MO3VE),
        build_place_command([2, 2], :NORTH),
        build_place_command([2, 10], :NORTH),
        build_simple_command(:RIGHtT),
        build_simple_command(:RE3PORT),
        build_place_command([8, 2], :NORTH),
        build_simple_command(:REPORT),
      ]

      expect do
        @table_game.execute(commands)
      end.to output('2,2,NORTH').to_stdout
    end
  end
end
