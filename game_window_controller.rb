# game_window_controller
# TextTwistClone
#
# Created by Nolan Waite on 10-02-11.
# Copyright 2010 Nolan Waite. All rights reserved.


class GameWindowController < NSWindowController
  attr_writer :score, :letters, :wordDisplayTable, :columnedWordDisplayer
  
  def initWithWindow(window)
    @game = Game.new
    super
  end
  
  def awakeFromNib
    newRound self
  end
  
  def enterString(sender)
    if @game.entered(sender.stringValue)
      @score.stringValue = "#{@game.score} points"
      update_word_display_array
    end
  end
  
  def newRound(sender)
    @game.new_round
    @letters.stringValue = @game.letters
    update_word_display_array
  end
  
  private
    def update_word_display_array
      @columnedWordDisplayer.wordArray = (@game.all_anagrams.to_a.collect do |a|
        @game.guessed.member?(a) ? a : '_ ' * a.length
      end.to_a)
      @wordDisplayTable.reloadData
    end
end
