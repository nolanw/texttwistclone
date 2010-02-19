# columned_word_displayer.rb
# TextTwistClone
#
# Created by Nolan Waite on 10-02-17.
# Copyright 2010 Nolan Waite. All rights reserved.

# Implements NSTableViewDataSource and listens to notifications and such to 
# nicely display a given list of words based on the size of the NSTableView.
# The number of columns changes based on width of the NSTableView, and the 
# contents of individual cells change as the player enters valid anagrams.
class ColumnedWordDisplayer
  attr_accessor :wordArray
  attr_writer :wordDisplay
  
  def initialize
    @wordArray = []
    self
  end
  
  # One word per row per column.
  def numberOfRowsInTableView(table_view)
    columns = table_view.tableColumns.size
    @wordArray.size / columns + [@wordArray.size % columns, 1].min
  end
  
  def tableView(table_view, objectValueForTableColumn:table_column, row:row)
    column = table_view.tableColumns.index table_column
    columns = table_view.tableColumns.size
    word = (row + 1) * columns - (columns - column)
    @wordArray.fetch(word, '')
  end
end
