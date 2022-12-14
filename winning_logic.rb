module WinningLogic
  private

  def find_rows(grid, dimension)
    rows = Array.new(dimension) { [] }

    grid.each_with_index do |row, row_index|
      row.each_with_index do |_col, col_index|
        location_index = [row_index, col_index]

        rows[row_index] << convert_index_to_location(location_index)
      end
    end

    rows
  end

  def find_columns(grid, dimension)
    columns = Array.new(dimension) { [] }

    grid.each_with_index do |row, row_index|
      row.each_with_index do |_col, col_index|
        location_index = [row_index, col_index]

        columns[col_index] << convert_index_to_location(location_index)
      end
    end

    columns
  end

  def find_diagonal_line_from_left(dimension)
    diagonal_line_from_left = []

    row_and_col = 0

    until row_and_col >= dimension
      diagonal_line_from_left << convert_index_to_location([row_and_col, row_and_col])

      row_and_col += 1
    end

    diagonal_line_from_left
  end

  def find_diagonal_line_from_right(dimension)
    diagonal_line_from_right = []

    row = 0
    col_from_end = dimension - 1

    until col_from_end.negative?
      diagonal_line_from_right << convert_index_to_location([row, col_from_end])

      col_from_end -= 1
      row += 1
    end

    diagonal_line_from_right
  end

  def find_diagonal_lines(dimension)
    diagonal_lines = []

    diagonal_lines << find_diagonal_line_from_left(dimension)
    diagonal_lines << find_diagonal_line_from_right(dimension)

    diagonal_lines
  end

  def find_winning_combinations(grid, dimension)
    winning_combinations = []

    winning_combinations << find_rows(grid, dimension)
    winning_combinations << find_columns(grid, dimension)
    winning_combinations << find_diagonal_lines(dimension)

    winning_combinations
  end

  def winner?(player_played_locations, winning_combinations)
    winning_combinations.each do |combination_category|
      combination_category.each do |combination|
        return true if (combination - player_played_locations).empty?
      end
    end
    false
  end
end
