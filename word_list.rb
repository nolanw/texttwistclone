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
end

module WordUtilities
  # Generate all same-length anagrams of str, appending them to words.
  # Example:
  # WordUtilities.anagrams('art', w = [])
  # p w
  # => ["art", "atr", "rat", "rta", "tar", "tra"]
  def self.anagrams(str, words, anagram='')
    if str.empty?
      words << anagram
    end
    str.length.times do |index|
      # Inspiration from:
      # http://lojic.com/blog/2007/10/22/solving-anagrams-in-ruby
      char = (temp = str.clone).slice!(index)
      anagrams(temp, words, anagram + char)
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
    WordUtilities.anagrams str, w = []
    w.select { |word| is_word? word }
  end
  
  def clear
    @words.clear
  end
end
