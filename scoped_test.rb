require 'minitest/autorun'
require_relative 'bowling_game'

# Common test data version: 1.2.0 1806718
class BowlingTest < Minitest::Test
  def test_consecutive_strikes_each_get_the_two_roll_bonus
    game = BowlingGame.new
    rolls = [10, 10, 10, 6, 4, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    # [10, nil, 10, nil, 10, nil, 6, 4, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    rolls.each { |pins| game.roll(pins) }
    assert_equal 99, game.score
  end
end
