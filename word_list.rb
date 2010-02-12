# word_list.rb
# TextTwistClone
#
# Created by Nolan Waite on 10-02-11.
# Copyright 2010 Nolan Waite. All rights reserved.
# 
# Handles loading a dictionary from a file, retrieving seven-letter words 
# therefrom, retrieving a list of anagrams given a string, and validating 
# whether a given string is a word.

class Array
  def rand
    self[rand(size)]
  end
end

class WordList
  def initialize(path)
    @words = Hash.new { |hash, key| hash[key] = [] }
    File.open(path).each do |word|
      @words[word.size] << word
    end
  end
  
  def randomSevenLetterWord
    @words[7].any
  end
  
  def anagrams(str)
  end
  
  def is_word?(str)
    @words[str.length].member? str
  end
end
