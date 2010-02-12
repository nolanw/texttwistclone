# game.rb
# TextTwistClone
#
# Created by Nolan Waite on 10-02-11.
# Copyright 2010 Nolan Waite. All rights reserved.
# 
# Keeps a list of players, knows the type of game being played, uses a 
# particular word list, knows the current seven-letter words, and scores words.

class Game
  attr_accessor :letters
  
  # Expects a Hash of options, which can include:
  #   - :dictionary => name of a built-in dictionary (if symbol)
  #                    path to some other deictionary (if not symbol)
  #
  # Examples:
  # 
  # Game.new :dictionary => 'ospd3.txt'
  # Game.new :dictionary => :ospd3
  #
  def initialize(options)
    if options[:dictionary]
      if options[:dictionary].kind_of? Symbol
        @word_list = WordList.new(NSBundle.mainBundle.pathForResource(options[:dictionary], ofType:'txt'))
      else
        @word_list = WordList.new options[:dictionary]
      end
    else
      @word_list = nil
    end
  end
  
  def score_for(str)
    return 0 unless defined? @letters
    return 0 unless @word_list.is_word?(str) and str.is_anagram_of?(@letters)
    10 * str.length
  end
  
  def new_round
    setLetters @word_list.random_seven_letter_word.split(//).sort.join
  end
end
