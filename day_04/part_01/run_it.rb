def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def word_at(pos, length, vector, full_board)
  pos_x, pos_y = pos
  vector_x, vector_y = vector
  word = full_board[pos_y][pos_x]
  (length-1).times do
    pos_x += vector_x
    pos_y += vector_y
    word = case
    when pos_x < 0 || full_board[0].size <= pos_x
      ''
    when pos_y < 0 || full_board.size <= pos_y
      ''
    else
      word + full_board[pos_y][pos_x]
    end
  end
  word
end

def count_xmas_at(pos, full_board)
  pos_x, pos_y = pos

  return 0 if pos_x < 0 || full_board[0].size <= pos_x
  return 0 if pos_y < 0 || full_board.size <= pos_y
  return 0 if full_board[pos_y][pos_x] != 'X'

  return [
    word_at(pos, 4, [-1, -1], full_board),
    word_at(pos, 4, [ 0, -1], full_board),
    word_at(pos, 4, [ 1, -1], full_board),
    word_at(pos, 4, [-1,  0], full_board),
    word_at(pos, 4, [ 1,  0], full_board),
    word_at(pos, 4, [-1,  1], full_board),
    word_at(pos, 4, [ 0,  1], full_board),
    word_at(pos, 4, [ 1,  1], full_board),
  ].select { |it| it == 'XMAS'}.count
end

def main
  lines = parse_input(load_input)

  res = 0
  lines.each_with_index do |line, y_idx|
    line.split('').each_with_index do |letter, x_idx|
      res += count_xmas_at([x_idx, y_idx], lines)
    end
  end

  puts res
end

main
