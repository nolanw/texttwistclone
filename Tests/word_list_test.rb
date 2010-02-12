# word_list_test.rb
# TextTwistClone
#
# Created by Nolan Waite on 10-02-11.
# Copyright 2010 Nolan Waite. All rights reserved.


require 'test/unit'
require 'word_list'
require 'set'

class WordListTest < Test::Unit::TestCase
  def setup
    @words = WordList.load_with_path 'ospd3.txt'
  end
  
  def test_append
    list = WordList.new
    assert !list.is_word?('foo'), "Expected empty WordList not to know 'foo'."
    list << 'foo'
    assert list.is_word?('foo'), "Expected WordList with 'foo' to know 'foo'."
  end
  
  def test_random_seven_letter_word
    10.times do
      word = @words.random_word_of_length 7
      assert_equal 7, word.length, "Expected '#{word}' to be length 7"
    end
  end
  
  def test_valid_words
    %w[boy fob lax pod axle tweak twice mildew mildly enforce].each do |word|
      assert @words.is_word?(word), "Expected '#{word}' to be valid"
    end
  end
  
  def test_invalid_words
    %w[arb, jaks, paulsa, bajyyak, ajslkd].each do |word|
      assert !@words.is_word?(word), "Expected '#{word}' to be invalid"
    end
  end
  
  def test_anagrams
    test_string = 'the'
    WordUtilities.anagrams(test_string, words=[])
    %w[the teh hte het eth eht].each do |word|
      assert words.member?(word), "Expected '#{word}' to be an angram of '#{test_string}'"
    end
  end
  
  def test_anagrammed_words
    anagrams = Set.new %w[tar rat art]
    assert_equal anagrams, Set.new(@words.anagrammed_words('tar'))
  end
  
  def test_is_anagram_of?
    assert 'art'.is_anagram_of?('rat'), "Expected 'art' to be an anagram of 'rat'"
    assert 'art'.is_anagram_of?('tarp'), "Expected 'art' to be an anagram of 'tarp'"
    assert !'the'.is_anagram_of?('fat'), "Expected 'the' not to be an anagram of 'fat'"
  end
end
