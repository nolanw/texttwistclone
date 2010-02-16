# word_list.rb
# TextTwistClone
#
# Created by Nolan Waite on 10-02-11.
# Copyright 2010 Nolan Waite. All rights reserved.
# 
# Handles loading a dictionary from a file, retrieving seven-letter words 
# therefrom, retrieving a list of anagrams given a string, and validating 
# whether a given string is a word.

class Set
  def any
    r = rand(size)
    each_with_index do |x, i|
      return x if i == r
    end
  end
end

class String
  # A hash where keys are letters and values are the number of instances 
  # of said letter in self.
  def letter_count
    letters = Hash.new { |hash, key| hash[key] = 0 }
    split(//).each { |c| letters[c] += 1 }
    letters
  end
  
  # Examples:
  # 'art'.is_anagram_of? 'rat'
  # => true
  # 'art'.is_anagram_of? 'tarp'
  # => true
  # 'the'.is_anagram_of? 'fat'
  # => false
  def is_anagram_of?(other)
    me = letter_count
    other = other.letter_count
    me.each_key { |k| return false unless other[k] and other[k] >= me[k] }
    true
  end
  
  # Return an Array of all substrings of length len.
  def substrings_of_length(len)
    split(//).combination(len).collect { |a| a.join }
  end
end

module WordUtilities
  # Generate all same-length anagrams of str.
  def self.anagrams(str)
    anagrams_helper(str, w = [])
    w
  end
  
  # Generate all same-length anagrams of str, appending them to words.
  # Example:
  # WordUtilities.anagrams_helper('art', w = [])
  # p w
  # => ["art", "atr", "rat", "rta", "tar", "tra"]
  private
    def self.anagrams_helper(str, words, anagram='')
      if str.empty?
        words << anagram
      end
      str.length.times do |index|
        # Inspiration from:
        # http://lojic.com/blog/2007/10/22/solving-anagrams-in-ruby
        char = (temp = str.clone).slice!(index)
        anagrams_helper(temp, words, anagram + char)
      end
    end
end

require 'set'

# A list of words with fast insert/lookup.
class WordList
  def initialize
    @words = Hash.new { |hash, key| hash[key] = Set.new }
  end
  
  def <<(word)
    @words[word.length] << word
  end
  
  # Return a new WordList with the contents of the file at path, which has 
  # one word per line.
  def self.load_with_path(path)
    list = self.new
    File.open(path).each do |word|
      list << word.strip.downcase
    end
    list
  end
  
  def is_word?(str)
    @words[str.length].member? str
  end
  
  alias :member? :is_word?
  
  def random_word_of_length(len)
    @words[len].any
  end
  
  def anagrammed_words(str)
    WordUtilities.anagrams(str).select { |word| is_word? word }
  end
  
  # Return a WordList of anagrams of str of any length that are words.
  def substring_anagrammed_words(str)
    wl = WordList.new
    (3..(str.size)).each do |len|
      str.substrings_of_length(len).each do |sub|
        wl << sub if is_word? sub
      end
    end
    wl
  end
  
  def clear
    @words.clear
  end
  
  def size
    if @words.empty?
      0
    else
      @words.values.inject(0) { |sum, s| sum + s.size }
    end
  end
  
  def to_a
    a = []
    @words.each_value { |w| a.concat w.to_a}
    a
  end
end
