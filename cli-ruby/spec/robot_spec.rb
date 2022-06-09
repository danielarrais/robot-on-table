require_relative '../lib/robot'

describe Robot do
  before do
    @robot = Robot.new(
      initial_position: [2, 2],
      max_area_to_move: [3, 3],
      facing: :NORTH
    )
  end

  describe "Move robot" do
    it "move for north invalid position" do
      @robot.move
      @robot.move
      @robot.move
      @robot.move

      expect do
        @robot.current_position_report
      end.to output('2,0,NORTH').to_stdout
    end

    it "move for east invalid position" do
      @robot.right
      @robot.move
      @robot.move

      expect do
        @robot.current_position_report
      end.to output('2,2,EAST').to_stdout
    end

    it "move for west invalid position" do
      @robot.left
      @robot.move
      @robot.move
      @robot.move
      @robot.move

      expect do
        @robot.current_position_report
      end.to output('0,2,WEST').to_stdout
    end

    it "move for south invalid position" do
      @robot.left
      @robot.left
      @robot.move
      @robot.move

      expect do
        @robot.current_position_report
      end.to output('2,2,SOUTH').to_stdout
    end

    it "move for multiples valids positions" do
      @robot.move
      @robot.left
      @robot.move
      @robot.left
      @robot.move
      @robot.right
      @robot.move
      @robot.right
      @robot.right
      @robot.move

      expect do
        @robot.current_position_report
      end.to output('1,2,EAST').to_stdout
    end
  end

  describe "Rotate robot" do
    it "rotate 360 for right" do
      @robot.right
      @robot.right
      @robot.right
      @robot.right

      expect do
        @robot.current_position_report
      end.to output('2,2,NORTH').to_stdout
    end

    it "rotate 360 for left" do
      @robot.left
      @robot.left
      @robot.left
      @robot.left

      expect do
        @robot.current_position_report
      end.to output('2,2,NORTH').to_stdout
    end

    it "rotate to right" do
      @robot.right

      expect do
        @robot.current_position_report
      end.to output('2,2,EAST').to_stdout
    end

    it "rotate to left" do
      @robot.left

      expect do
        @robot.current_position_report
      end.to output('2,2,WEST').to_stdout
    end
  end
end
