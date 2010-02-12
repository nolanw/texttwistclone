# player_test.rb
# TextTwistClone
#
# Created by Nolan Waite on 10-02-11.
# Copyright 2010 Nolan Waite. All rights reserved.


require 'test/unit'
require 'player'
require 'game'

class PlayerTest < Test::Unit::TestCase
  def setup
    @game = Game.new :dictionary => 'ospd3.txt'
    @game.new_round 'boylaxaxletweaktwicemildewmildlyenforce'
    @player = Player.new @game
  end
  
  def test_score_with_valid_words
    assert_equal 0, @player.score, "Expected player's initial score to be 0"
    %w[boy lax axle tweak twice mildew mildly enforce].each do |word|
      @player.entered word
    end
    assert_equal 390, @player.score, "Expected player's score to be 390, but was #{@player.score}"
  end
  
  def test_score_with_same_word_multiple_times
    %w[boy boy boy].each do |word|
      @player.entered word
    end
    assert_equal 30, @player.score, "Expected player's score to be 30, but was #{@player.score}"
  end
end
