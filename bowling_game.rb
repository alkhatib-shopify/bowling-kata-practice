class Rolls
  def initialize
    @rolls = []
  end

  def add(pins)
    @rolls.push pins
  end

  def get(frame_idx)
    @rolls[frame_idx]
  end
end

class BowlingGame
  class BowlingError < StandardError; end

  def initialize
    @new_roll = Rolls.new
  end

  # rolls don't have the notion of when frame starts and ends

  def roll(pins)
    raise BowlingError unless pins.between?(0, 10)

    @new_roll.add pins
  end

  NUM_OF_FRAMES = 10

  # repeat 10 times
  # given a start of frame, how many score it contains
  # should I proceed once (strike) or twice (rest)
  def score
    score = 0
    frame_idx = 0

    NUM_OF_FRAMES.times do
      score += sum_of_balls_in_frame(frame_idx) + frame_bonus(frame_idx)
      frame_idx += number_of_rolls_in_frame(frame_idx)
    end

    score
  end

  private

  # is_strike conditional looks similar pattern
  # frame_idx: beginning of a frame in rolls array
  # else: two rolls except spare
  def number_of_rolls_in_frame(frame_idx)
    if is_strike(frame_idx)
      1
    elsif is_spare(frame_idx)
      2
    else
      2
    end
  end

  def sum_of_balls_in_frame(frame_idx)
    if is_strike(frame_idx)
      @new_roll.get(frame_idx)
    elsif is_spare(frame_idx)
      @new_roll.get(frame_idx) + @new_roll.get(frame_idx + 1)
    else
      @new_roll.get(frame_idx) + @new_roll.get(frame_idx + 1)
    end
  end

  # to check special conditions
  # frame_idx: beginning of a frame in rolls array
  def is_spare(frame_idx)
    @new_roll.get(frame_idx) + @new_roll.get(frame_idx + 1) == 10
  end

  def is_strike(frame_idx)
    @new_roll.get(frame_idx) == 10
  end

  ## Scoring Concern

  def frame_bonus(frame_idx)
    if is_strike(frame_idx)
      strike_bonus(frame_idx)
    elsif is_spare(frame_idx)
      spare_bonus(frame_idx)
    else
      0
    end
  end

  # bonus calculation
  # frame_idx: beginning of a frame in rolls array
  def spare_bonus(frame_idx)
    @new_roll.get(frame_idx + 2)
  end

  def strike_bonus(frame_idx)
    @new_roll.get(frame_idx + 1) + @new_roll.get(frame_idx + 2)
  end
end
