class BowlingGame
  class BowlingError < StandardError; end

  class Frame
    def initialize
      @capacity = 10
    end

    # validation per frame
    # generation of new frame
    def roll(pins)
      if @roll1.nil?
        @roll1 = pins
        return self
      else
        raise BowlingError unless (@roll1 + pins).between?(0,10)
        # @roll2 = pins
        return Frame.new
      end
    end
  end

  def initialize
    @rolls = Array.new(21) { 0 }
    @current_roll = 0
    @current_frame = Frame.new
  end

  # rolls don't have the notion of when frame starts and ends

  def roll(pins)
    raise BowlingError unless pins.between?(0, 10)
    @current_frame = @current_frame.roll(pins)
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

  private

  # to check special conditions
  # frame_idx: beginning of a frame in rolls array
  def is_spare(frame_idx)
    @rolls[frame_idx] + @rolls[frame_idx + 1] == 10
  end

  def is_strike(frame_idx)
    @rolls[frame_idx] == 10
  end

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

  #
  # def sum_of_balls_in_frame(frame)
  #   if frame.is_strike
  #     frame.roll1
  #   elsif frame.is_spare
  #     frame.roll1 + frame.roll2
  #   else
  #     frame.roll1 + frame.roll2
  #   end
  # end

  # frame_idx -> frame object
  # is_stirke/is_spare -> frame object
  # roll1/roll1 -> frame object

  def sum_of_balls_in_frame(frame_idx)
    # StrikeSpareOtherState.new.sum_of_balls_in_frame
    if is_strike(frame_idx)
      @rolls[frame_idx] + 0
    elsif is_spare(frame_idx)
      @rolls[frame_idx] + @rolls[frame_idx + 1]
    else
      @rolls[frame_idx] + @rolls[frame_idx + 1]
    end
  end

  #SCORING
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
    @rolls[frame_idx + 2]
  end

  def strike_bonus(frame_idx)
    @rolls[frame_idx + 1] + @rolls[frame_idx + 2]
  end
end

# class Frame
class StrikeSpareOtherState
  def initialize(strike_spare_or_normal)
    @strike_spare_or_normal = strike_spare_or_normal
  end

  def number_of_rolls_in_frame
    if @strike_spare_or_normal.is_strike
      1
    elsif @strike_spare_or_normal.is_spare
      2
    else
      2
    end
  end
end