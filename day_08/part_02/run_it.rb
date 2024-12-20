def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

class Position
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def ==(other)
    self.class == other.class &&
      x == other.x &&
      y == other.y
  end
  alias :eql? :==

  def hash
    [@x, @y].hash
  end

  def to_s
    "<Pos [x: #{@x}, y: #{@y}]>"
  end
end

def antinodes_for(pos1, pos2, board)
  delta = [pos2.x-pos1.x, pos2.y-pos1.y]

  res = []

  new_pos = Position.new(pos1.x-delta[0], pos1.y-delta[1])
  while valid_pos?(new_pos, board)
    res << new_pos
    new_pos = Position.new(new_pos.x-delta[0], new_pos.y-delta[1])
  end

  new_pos = Position.new(pos2.x+delta[0], pos2.y+delta[1])
  while valid_pos?(new_pos, board)
    res << new_pos
    new_pos = Position.new(new_pos.x+delta[0], new_pos.y+delta[1])
  end

  res
end

def valid_pos?(pos, board)
  (0 <= pos.x && pos.x < board[0].size) && (0 <= pos.y && pos.y < board.size)
end

def main
  lines = parse_input(load_input)

  antennas = Hash.new { Set.new }

  lines.each_with_index do |line, idx_y|
    line.split('').each_with_index do |pos, idx_x|
      if pos != '.'
        antennas[pos] = antennas[pos].add(Position.new(idx_x, idx_y))
      end
    end
  end

  antinodes = Set.new

  antennas.each do |k, v|
    v.to_a.combination(2).each do |(a, b)|
      antinodes.add(a)
      antinodes.add(b)
      antinodes_for(a, b, lines).each do |antinode|
        antinodes.add(antinode)
      end
    end
  end

  pp antinodes.count
end

main
