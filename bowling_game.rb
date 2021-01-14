class BowlingGame
  class BowlingError < StandardError; end

  def initialize
    @rolls = Array.new(21) { 0 }
    @current_roll = 0

    @frames = Array.new(10) { [] }
    @current_frame = 0
  end

  def roll(pins)
    raise BowlingError unless pins.between?(0, 10)

    @rolls[@current_roll] = pins
    @current_roll += 1

    @frames[@current_frame].push pins

    # raise an error if this is the second roll in a frame and the total exceeds 10
    sum_of_balls_in_frame = @frames[@current_frame].reduce(0) { |sum, n| sum += n }
    raise BowlingError if @current_frame < 9 && sum_of_balls_in_frame > 10

    # Rule of proceeding to next frame
    #   1. strike
    #   2. second roll in a frame is already filled
    if @current_frame < 9 &&  (pins == 10 || @frames[@current_frame][1])
      @current_frame += 1
    end
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
    if is_strike(frame_idx)
      1
    else
      2
    end
  end

  def frame_bonus(frame_idx)
    if is_strike(frame_idx)
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
    @rolls[frame_idx] == 10
  end

  def sum_of_balls_in_frame(frame_idx)
    if is_strike(frame_idx)
      @rolls[frame_idx] + 0
    else
      @rolls[frame_idx] + @rolls[frame_idx + 1]
    end
  end

  def spare_bonus(frame_idx)
    @rolls[frame_idx + 2]
  end

  def strike_bonus(frame_idx)
    @rolls[frame_idx + 1] + @rolls[frame_idx + 2]
  end
end
