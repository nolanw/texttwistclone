# word_list_test.rb
# TextTwistClone
#
# Created by Nolan Waite on 10-02-11.
# Copyright 2010 Nolan Waite. All rights reserved.


require 'test/unit'

require 'word_list'

framework 'Foundation'

class SimpleTest < Test::Unit::TestCase
  # def setup
  #   puts 'setup called'
  # end
  # 
  # def teardown
  #   puts 'teardown called'
  # end
  # 
  def test_load_from_file
    assert WordList.new('ospd3.txt')
  end
end