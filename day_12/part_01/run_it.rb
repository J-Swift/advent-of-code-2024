def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def is_valid?(pos, board)
  x, y = pos
  (0 <= x && x < board[0].size) && (0 <= y && y < board.size)
end

def get_all_touching(pos, board, res = Set.new)
  x, y = pos
  res.add(pos)
  val = board[y][x]

  candidates = [
    [x-1, y],
    [x+1, y],
    [x, y-1],
    [x, y+1],
  ]

  candidates.each do |candidate|
    if is_valid?(candidate, board) && board[candidate[1]][candidate[0]] == val && !res.member?(candidate)
      res.add(candidate)
      get_all_touching(candidate, board, res)
    end
  end

  res
end

def get_area(region)
  region.count
end

def get_perimeter(region, board)
  val = board[region.first[1]][region.first[0]]

  total = 0
  region.each do |(x, y)|
    candidates = [
      [x-1, y],
      [x+1, y],
      [x, y-1],
      [x, y+1],
    ]

    candidates.each do |candidate|
      if !is_valid?(candidate, board) || (is_valid?(candidate, board) && board[candidate[1]][candidate[0]] != val)
        total += 1
      end
    end
  end

  total
end

def main
  lines = parse_input(load_input)

  regions = []
  already_grouped = Set.new

  lines.each_with_index do |line, idx_y|
    line.split('').each_with_index do |char, idx_x|
      if !already_grouped.member?([idx_x, idx_y])
        res = get_all_touching([idx_x, idx_y], lines)
        regions.append([char, res])
        already_grouped += res
      end
    end
  end

  # pp regions
  res = regions.reduce(0) do |memo, (char, r)|
    area = get_area(r)
    perimeter = get_perimeter(r, lines)
    memo + (area * perimeter)
    # puts "[#{char}] [#{area}] [#{perimeter}]"
  end
  puts res
end

main
