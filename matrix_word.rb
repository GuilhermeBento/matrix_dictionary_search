# Define matrix word object
class MatrixWord
  attr_accessor :direction, :word, :place
  def initialize(word)
    @place = nil
    @word = word
    @direction = 0
  end
end
