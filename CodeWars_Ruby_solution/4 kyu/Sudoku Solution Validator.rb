def validSolution(board)
    # return false if board.nil?
    stand = [1,2,3,4,5,6,7,8,9]
    board.each do |row|
      a = stand - row
      return false if !a.empty?
    end
    board.transpose.each do |col|
      b = stand - col
      return false if !b.empty?
    end
    3.times do |i|
      i *= 3
      k = board[i][0..2] + board[i + 1][0..2] + board[i + 2][0..2]
      k = stand - k
      return false if !k.empty?
      k = board[i][3..5] + board[i + 1][3..5] + board[i + 2][3..5]
      k = stand - k
      return false if !k.empty?
      k = board[i][6..8] + board[i + 1][6..8] + board[i + 2][6..8]
      k = stand - k
      return false if !k.empty?
    end
    return true
  end