# game.rb
# TextTwistClone
#
# Created by Nolan Waite on 10-02-19.
# Copyright 2010 Nolan Waite. All rights reserved.


require 'word_list'

class Game
  attr_reader :all_anagrams, :guessed, :score, :letters
  
  def initialize(options = {})
    load_dictionary options.fetch(:dictionary, :ospd3)
  end
  
  def new_round
    @letters = @word_list.random_word_of_length(7).split(//).sort.join
    @all_anagrams = @word_list.substring_anagrammed_words @letters
    @guessed = WordList.new
    @score ||= 0
  end
  
  def score_for(str)
    return 0 unless defined? @letters
    if @word_list.is_word? str and str.is_anagram_of? @letters
      10 * str.length
    else
      0
    end
  end
  
  def entered(str)
    word_score = score_for str
    if word_score > 0 and not @guessed.member? str
      @guessed << str
      @score += word_score
      true
    else
      false
    end
  end
  
  private
    def load_dictionary(dictionary)
      bundle = NSBundle.mainBundle
      @word_list = WordList.load_with_path bundle.pathForResource(dictionary, ofType:'txt')
      @word_list = WordList.load_with_path dictionary unless @word_list
    end
end
