# game_window_controller
# TextTwistClone
#
# Created by Nolan Waite on 10-02-11.
# Copyright 2010 Nolan Waite. All rights reserved.


class GameWindowController < NSWindowController
  attr_reader :game, :player
  attr_writer :score, :letters, :total_anagrams, :anagrams_so_far
  
  def initWithWindow(window)
    @game = Game.new :dictionary => :ospd3
    @player = Player.new @game
    super
  end
  
  def enterString(sender)
    @player.entered(sender.stringValue)
    @score.integerValue = @player.score
    @anagrams_so_far.integerValue = @player.guessed.size
  end
  
  def newRound(sender)
    @game.new_round
    @letters.stringValue = @game.letters
    @total_anagrams.integerValue = @game.total_anagrams
    @anagrams_so_far.integerValue = 0
  end
end
