def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines.map do |line|
    line.split('').map(&:to_i)
  end
end

def is_valid?(pos, board)
  x, y = pos
  (0 <= x && x < board[0].size) && (0 <= y && y < board.size)
end

def trailheads_from(pos, board)
  x, y = pos
  return Set.new unless is_valid?(pos, board)

  val = board[y][x]
  return Set.new([pos]) if val == 9

  possibles = [
    [x-1, y],
    [x+1, y],
    [x, y-1],
    [x, y+1],
  ]
  valid = possibles.filter { |it| is_valid?(it, board) && board[it[1]][it[0]] - val == 1 }
  valid.reduce(Set.new) { |memo, it| memo + trailheads_from(it, board) }
end

def main
  lines = parse_input(load_input)

  res = []
  lines.each_with_index do |line, idx_y|
    line.each_with_index do |val, idx_x|
      if val == 0
        res.push(trailheads_from([idx_x, idx_y], lines).count)
      end
    end
  end

  puts res.reduce(&:+)
end

main
