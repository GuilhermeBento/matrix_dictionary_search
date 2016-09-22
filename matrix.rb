# Convert a natural number to its Roman number equivalent.
require 'pry'
require './matrix_options'
require './matrix_word'

class Matrix < MatrixOptions
  def initialize(size)
    @width = size
    @height = size
    @grid = '.' * (@width * @height)
    fill_with_random_chars

  end

  # Represents the grid in a matrix NxN format for printing
  def print
    grid_array = []
    @height.times do |r|
      grid_array << @grid[r * @width, @width].split('') * ' '
    end
    grid_array
  end

  # find the words in the grid
  def find_words(words)
    @words = words.map { |w| MatrixWord.new(w) }
    @words.each { |mw| place mw if (!mw.word.nil? && mw.word.size <= @width) }
    @words.select { |w| !w.place.nil? }
  end

  private

  def fill_with_random_chars
    @grid.size.times { |i| @grid[i] = ('A'..'Z').to_a[rand(25)] }
  end
end
