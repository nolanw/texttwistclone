# word_list_test.rb
# TextTwistClone
#
# Created by Nolan Waite on 10-02-11.
# Copyright 2010 Nolan Waite. All rights reserved.


require 'test/unit'
require 'word_list'

class WordListTest < Test::Unit::TestCase
  def setup
    @words = WordList.new 'ospd3.txt'
  end
  
  def test_seven_letter_word
    10.times do
      word = @words.randomSevenLetterWord
      assert_equal word.length, 7, "Expected '#{word}' to be length 7."
    end
  end
  
  def test_valid_words
    %w[boy fob lax pod axle tweak twice mildew mildly enforce].each do |word|
      assert @words.is_word?(word), "Expected '#{word}' to be valid."
    end
  end
end