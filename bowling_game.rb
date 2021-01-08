class BowlingGame
  def initialize
    @rolls = Array.new(21) { 0 }
    @current_roll = 0
  end

  def roll(pins)
    @rolls[@current_roll] = pins
    @current_roll += 1
  end

  def score
    score = 0
    frame_idx = 0
    num_of_frames = 10

    num_of_frames.times do
      if is_strike(frame_idx)
        score += 10 + strike_bonus(frame_idx)
        frame_idx += 1
      elsif is_spare(frame_idx)
        score += 10 + spare_bonus(frame_idx)
        frame_idx+=2
      else
        score += sum_of_balls_in_frame(frame_idx)
        frame_idx += 2
      end
    end

    score
  end

  def is_spare(frame_idx)
    @rolls[frame_idx] + @rolls[frame_idx + 1] == 10
  end

  def is_strike(frame_idx)
    @rolls[frame_idx] == 10
  end

  def sum_of_balls_in_frame(frame_idx)
    @rolls[frame_idx] + @rolls[frame_idx + 1]
  end

  def spare_bonus(frame_idx)
    @rolls[frame_idx + 2]
  end

  def strike_bonus(frame_idx)
    @rolls[frame_idx+1] + @rolls[frame_idx+2]
  end
end