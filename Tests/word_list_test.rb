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
    words = WordUtilities.anagrams test_string
    %w[the teh hte het eth eht].each do |word|
      assert words.member?(word), "Expected '#{word}' to be an angram of '#{test_string}'"
    end
  end
  
  def test_substrings_of_length
    subs_two = 'the'.substrings_of_length(2).sort!
    assert_equal %w[he te th], subs_two, "Unknown or incomplete 2-substrings of 'the': #{subs_two}"
    subs_three = 'the'.substrings_of_length(3)
    assert_equal ['the'], subs_three, "Expected ['the'] but got #{subs_three}"
  end
  
  def test_substring_anagrammed_words
    anagrams_then = @words.substring_anagrammed_words('then')
    assert_equal %w[hen ten the then], anagrams_then.to_a.sort, "Expected hen, ten, the, then as anagrams of 'then', but got #{anagrams_then.to_a.sort}"
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
  
  def test_size
    words = WordList.new << 'one' << 'two' << 'three' << 'four' << 'five'
    assert_equal 5, words.size, "Expected there to be five words, but had #{words.size}"
    empty_words = WordList.new
    assert_equal 0, empty_words.size, "Expected there to be no words, but had #{empty_words.size}"
  end
  
  def test_to_a
    words = WordList.new << 'a' << 'be' << 'see'
    assert_equal %w[a be see], words.to_a.sort!, "Expected a, be, see, but got #{words.to_a.sort}"
  end
end
