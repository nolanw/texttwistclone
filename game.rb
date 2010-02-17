# game.rb
# TextTwistClone
#
# Created by Nolan Waite on 10-02-11.
# Copyright 2010 Nolan Waite. All rights reserved.
# 
# Keeps a list of players, knows the type of game being played, uses a 
# particular word list, knows the current seven-letter words, and scores words.

require 'word_list'

class Game
  attr_reader :letters, :total_anagrams
  
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
        @word_list = WordList.load_with_path NSBundle.mainBundle.pathForResource(options[:dictionary], ofType:'txt')
      else
        @word_list = WordList.load_with_path options[:dictionary]
      end
    else
      @word_list = nil
    end
  end
  
  def score_for(str)
    if not defined? @letters
      0
    elsif @word_list.is_word? str and str.is_anagram_of? @letters
      10 * str.length
    else
      0
    end
  end
  
  def new_round(str = nil)
    str = @word_list.random_word_of_length(7) unless str
    @letters = str.split(//).sort.join
    @all_anagrams = @word_list.substring_anagrammed_words str
    @total_anagrams = @all_anagrams.size
  end
end
