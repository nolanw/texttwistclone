# player.rb
# TextTwistClone
#
# Created by Nolan Waite on 10-02-11.
# Copyright 2010 Nolan Waite. All rights reserved.
# 
# Keeps score for a player, adds to score given input string (first ensuring 
# it's a valid word), and handles player metadata (e.g. name).

class Player
  attr_reader :guessed, :score
  
  def initialize(game)
    @game = game
    @score = 0
    @guessed = WordList.new
  end
  
  def entered(str)
    word_score = @game.score_for str
    if word_score > 0 and not @guessed.member? str
      @guessed << str
      @score += word_score
    end
    @score
  end
  
  def clear_words_guessed
    @guessed.clear
  end
end
