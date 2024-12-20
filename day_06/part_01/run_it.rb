def load_input
  File.readlines('input_test.txt').map(&:strip)
end

def parse_input(lines)
  lines.map { |line| line.split('') }
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

def next_direction(current_direction)
  case current_direction
  when :up then :right
  when :right then :down
  when :down then :left
  when :left then :up
  end
end

def get_space(position, map)
  case
  when !((0 <= position.y && position.y < map.size) && (0 <= position.x && position.x < map[0].size))
    :oob
  when map[position.y][position.x] == '#'
    :blocked
  else
    :empty
  end
end

def translate_position_in_direction(current_position, direction)
  case direction
  when :up
    Position.new(current_position.x, current_position.y - 1)
  when :down
    Position.new(current_position.x, current_position.y + 1)
  when :left
    Position.new(current_position.x - 1, current_position.y)
  when :right
    Position.new(current_position.x + 1, current_position.y)
  end
end

def main
  lines = parse_input(load_input)

  current_position = nil
  lines.each_with_index do |line, idx_y|
    line.each_with_index do |pos, idx_x|
      current_position = Position.new(idx_x, idx_y) if pos == '^'
    end
  end

  current_direction = :up
  visited = Set.new([current_position])

  new_position = translate_position_in_direction(current_position, current_direction)
  new_space = get_space(new_position, lines)
  while new_space != :oob
    if new_space == :blocked
      current_direction = next_direction(current_direction)
    else
      visited.add(current_position)
      current_position = new_position
    end
    new_position = translate_position_in_direction(current_position, current_direction)
    new_space = get_space(new_position, lines)
  end

  visited.add(current_position)
  puts visited.count
end

main
