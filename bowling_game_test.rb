require "minitest/autorun"
require_relative 'bowling_game'

describe BowlingGame do
  before do
    @g = BowlingGame.new
  end

  it "scores 0 when no pins are hit" do
    20.times { @g.roll(0) }
    _(@g.score()).must_equal 0
  end

  it "scores 20 when 1 pin is hit in each roll" do
    20.times { @g.roll(1) }
    _(@g.score()).must_equal 20
  end

  it "scores one spare and calculates the appropriate bonus" do
    roll_spare
    @g.roll(3)
    17.times { @g.roll(0) }
    _(@g.score).must_equal 16
  end

  it "scores one strike and calculates the appropriate bonus" do
    roll_strike
    @g.roll(3)
    @g.roll(4)
    16.times { @g.roll(0) }
    _(@g.score).must_equal 24
  end

  it "scores 300 when perfect game" do
    12.times { @g.roll(10) }
    _(@g.score).must_equal 300
  end

  def roll_strike
    @g.roll(10)
  end

  def roll_spare
    @g.roll(5)
    @g.roll(5)
  end
end
