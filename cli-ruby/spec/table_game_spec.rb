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
  end
end
