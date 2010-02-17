# game_window_controller
# TextTwistClone
#
# Created by Nolan Waite on 10-02-11.
# Copyright 2010 Nolan Waite. All rights reserved.


class GameWindowController < NSWindowController
  attr_reader :game, :player
  attr_writer :score, :letters, :wordDisplayTable, :columnedWordDisplayer
  
  def initWithWindow(window)
    @game = Game.new :dictionary => :ospd3
    @player = Player.new @game
    super
  end
  
  def awakeFromNib
    newRound self
  end
  
  def enterString(sender)
    @player.entered(sender.stringValue)
    @score.stringValue = "#{@player.score} points"
    update_word_display_array
  end
  
  def newRound(sender)
    @game.new_round
    @letters.stringValue = @game.letters
    update_word_display_array
  end
  
  private
    def update_word_display_array
      @columnedWordDisplayer.wordArray = (@game.all_anagrams.to_a.collect do |a|
        @player.guessed.member?(a) ? a : '_ ' * a.length
      end.to_a)
      @wordDisplayTable.reloadData
    end
end
