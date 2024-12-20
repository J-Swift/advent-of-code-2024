def load_input
  File.readlines('input.txt').map(&:strip)
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

def simulate(current_position, current_direction, map)
  visited = Set.new([[current_position, current_direction]])

  new_position = translate_position_in_direction(current_position, current_direction)
  new_space = get_space(new_position, map)
  while new_space != :oob
    if new_space == :blocked
      current_direction = next_direction(current_direction)
    else
      visited.add([current_position, current_direction])
      current_position = new_position
    end
    return :loops if visited.member?([current_position, current_direction])
    new_position = translate_position_in_direction(current_position, current_direction)
    new_space = get_space(new_position, map)
  end

  return :terminates
end

def new_map_with_blockage_at(position, map)
  return nil unless map[position.y][position.x] == '.'

  map.each_with_index.map do |line, idx_y|
    line.each_with_index.map do |pos, idx_x|
      if idx_x == position.x && idx_y == position.y
        '#'
      else
        pos
      end
    end
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

  res = Set.new

  lines.each_with_index do |line, idx_y|
    line.each_with_index do |pos, idx_x|
      new_lines = new_map_with_blockage_at(Position.new(idx_x, idx_y), lines)
      next unless new_lines
      if :loops == simulate(current_position, current_direction, new_lines)
        res.add(Position.new(idx_x, idx_y))
      end
    end
  end

  puts res.count
end

main
