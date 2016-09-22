# Options to search and modify matrix
class MatrixOptions
  DIRECTIONS = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
  TEXT_DIRECTION = {'0': 'vertical, from top to bottom', '1': 'diagonal, bottom-right',
                    '2': 'horizontal, from left to right', '3': 'diagonal, top-right',
                    '4': 'vertical, from bottom to top', '5': 'diagonal, top-left',
                    '6': 'horizontal, from right to left','9': 'diagonal, bottom-left' }

  # It tries to find the word in the grid
  def place(matrix_word)
    (@width * @height).times do |start_point|
      break if test_place(matrix_word, start_point)
    end
  end

  # Tests all 8 directions for word.
  def test_place(matrix_word, start_point)
    8.times do |dir|
      current_point = start_point
      good = true
      matrix_word.word.each_byte do |chr|
        good = (@grid[current_point].ord == chr) && (current_point = next_point(current_point, dir))
        break unless good
      end
      # If good (word found in start_point point and with @direction direction), it marks the word and returns.
      return mark_word(matrix_word, start_point, dir) if good
      # If it did not succeed with that direction, it tries with the next one
      dir = (dir + 1) % 8
    end
    nil  
  end

  # It finds the next grid index in given direction
  def next_point(pos, dir)
    #It does not allow to step off the edges, so we check them out:
    return nil if (pos < @width && (3..5).cover?(dir))
    return nil if (pos + @width >= @grid.size && [0, 1, 7].include?(dir))
    return nil if ((pos % @width).zero? && (5..7).cover?(dir))
    return nil if (pos % @width + 1 == @width && (1..4).cover?(dir))
    # DIRECTIONS = [[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1],[0,-1],[1,-1]]
    # DIRECTIONS[@direction][0]  y index. DIRECTIONS[@direction][1] x index
    pos + MatrixOptions::DIRECTIONS[dir][0] * @width + MatrixOptions::DIRECTIONS[dir][1]
  end

  def mark_word(dw, idx, dir)
    dw.direction = get_direction_in_text dir
    dw.place = calculate_coordinate_in_grid idx
  end

  def calculate_coordinate_in_grid(idx)
    coordinate_y = idx / @width
    coordinate_x = idx % @width
    [coordinate_x, coordinate_y]
  end

  # Prevent huge cases
  def get_direction_in_text(dir)
    return TEXT_DIRECTION[:'9'] if TEXT_DIRECTION[dir.to_s.to_sym].nil?
    TEXT_DIRECTION[dir.to_s.to_sym]
  end
end