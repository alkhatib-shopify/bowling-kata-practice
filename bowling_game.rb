class BowlingGame
  class BowlingError < StandardError; end

  def initialize
    @rolls = Array.new(21) { 0 }
    @current_roll = 0
  end

  def roll(pins)
    raise BowlingError unless pins.between?(0, 10)

    @rolls[@current_roll] = pins
    @current_roll += 1
  end

  NUM_OF_FRAMES = 10

  def score
    score = 0
    frame_idx = 0

    NUM_OF_FRAMES.times do
      score += sum_of_balls_in_frame(frame_idx) + frame_bonus(frame_idx)
      frame_idx += number_of_rolls_in_frame(frame_idx)
    end

    score
  end

  def number_of_rolls_in_frame(frame_idx)
    frame = BowlingGame::Frame.new
    frame.add_roll(@rolls[frame_idx])
    if frame.strike?
      1
    else
      2
    end
  end

  def frame_bonus(frame_idx)
    frame = BowlingGame::Frame.new
    frame.add_roll(@rolls[frame_idx])
    if frame.strike?
      strike_bonus(frame_idx)
    elsif is_spare(frame_idx)
      spare_bonus(frame_idx)
    else
      0
    end
  end

  def is_spare(frame_idx)
    sum_of_balls_in_frame(frame_idx) == 10
  end

  def is_strike(frame_idx)
    frame = BowlingGame::Frame.new
    frame.add_roll(@rolls[frame_idx])
    frame.strike?
  end

  def sum_of_balls_in_frame(frame_idx)
    frame = BowlingGame::Frame.new
    frame.add_roll(@rolls[frame_idx])
    unless frame.strike?
      frame.add_roll(@rolls[frame_idx + 1])
    end
    frame.sum_of_balls_in_frame
  end

  def spare_bonus(frame_idx)
    @rolls[frame_idx + 2]
  end

  def strike_bonus(frame_idx)

    @rolls[frame_idx + 1] + @rolls[frame_idx + 2]
  end
end

class BowlingGame::Frame
  def initialize
    @rolls = []
  end
  def add_roll(roll)
    @rolls << roll
  end
  def strike?
    @rolls[0] == 10
  end
  def sum_of_balls_in_frame
    @rolls.sum
  end
end