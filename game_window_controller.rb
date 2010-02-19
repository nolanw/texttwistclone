# game_window_controller
# TextTwistClone
#
# Created by Nolan Waite on 10-02-11.
# Copyright 2010 Nolan Waite. All rights reserved.


class Fixnum
  def pluralize
    self == 1 ? '' : 's'
  end
end


class GameWindowController < NSWindowController
  attr_writer :score, :letters, :wordDisplayTable, :columnedWordDisplayer, :timeRemaining, :newRoundGameTabs
  
  def awakeFromNib
    newGame self
  end
  
  def enterString(sender)
    if @game.entered(sender.stringValue)
      @score.stringValue = "#{@game.score} points"
      update_word_display_array
    end
  end
  
  def newRound(sender)
    if defined? @timer and @timer
      @timer.invalidate
    end
    @game.new_round
    @letters.stringValue = @game.letters
    @timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector:'tick:', userInfo:nil, repeats:true)
    @seconds_left = 60
    @newRoundGameTabs.selectTabViewItemWithIdentifier 'empty'
    update_word_display_array
    update_time_remaining
  end
  
  def tick(timer)
    @seconds_left -= 1
    if @seconds_left <= 0
      @timer.invalidate
      @timer = nil
      if @game.end_round
        @timeRemaining.stringValue = "You made it to the next round!"
        @newRoundGameTabs.selectTabViewItemWithIdentifier 'next_round'
      else
        @timeRemaining.stringValue = "Game over."
        @newRoundGameTabs.selectTabViewItemWithIdentifier 'new_game'
      end
    else
      update_time_remaining
    end
  end
  
  def newGame(sender)
    @game = Game.new
    newRound self
    @score.stringValue = "0 points"
  end
  
  private
    def update_word_display_array
      @columnedWordDisplayer.wordArray = (@game.all_anagrams.to_a.collect do |a|
        @game.guessed.member?(a) ? a : '_ ' * a.length
      end.to_a)
      @wordDisplayTable.reloadData
    end
    
    def update_time_remaining
      @timeRemaining.stringValue = "#{@seconds_left} second#{@seconds_left.pluralize} remaining"
    end
end
