# player_test.rb
# TextTwistClone
#
# Created by Nolan Waite on 10-02-11.
# Copyright 2010 Nolan Waite. All rights reserved.


require 'test/unit'
require 'player'
require 'game'

class PlayerTest < Test::Unit::TestCase
  def test_score_with_valid_words
    player = Player.new(Game.new :dictionary => 'ospd3.txt')
    assert_equal player.score, 0, "Expected player's initial score to be 0"
    %w[boy lax axle tweak twice mildew mildly enforce].each do |word|
      player.entered word
    end
    assert_equal player.score, 390, "Expected player's score to be 390, but was #{player.score}"
  end
end
