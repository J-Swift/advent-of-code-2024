def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

Robot = Struct.new(:px, :py, :vx, :vy)
BOARD_W = 101
BOARD_H = 103

def parse_robots(lines)
  res = []
  lines.each do |line|
    pos_config, v_config = line.split(' ')
    px, py = pos_config.split('=')[1].split(',').map(&:to_i)
    vx, vy = v_config.split('=')[1].split(',').map(&:to_i)
    res << Robot.new(px, py, vx, vy)
  end
  res
end

def tick(robot, num_ticks)
  px = (robot.px + robot.vx * num_ticks) % (BOARD_W)
  py = (robot.py + robot.vy * num_ticks) % (BOARD_H)

  Robot.new(px, py, robot.vx, robot.vy)

end

def display(robots)
  positions = robots.reduce(Set.new) { |memo, robot| memo.add([robot.px, robot.py]) }

  BOARD_H.times do |y|
    BOARD_W.times do |x|
      print (positions.member?([x, y]) ? 'X' : '.')
    end
    puts
  end
end

def count_num_neighbors(robots)
  positions = robots.reduce(Set.new) { |memo, robot| memo.add([robot.px, robot.py]) }

  robots.reduce(0) do |memo, robot|
    x, y = robot.px, robot.py

    offsets = [
      [-1, -1],
      [0, -1],
      [1, -1],

      [-1, 0],
      [1, 0],

      [-1, 1],
      [0, 1],
      [1, 1],
    ]

    offsets.each do |(dx, dy)|
      if positions.member?([x+dx, y+dy])
        memo += 1
      end
    end
    memo
  end
end

def main
  lines = parse_input(load_input)

  robots = parse_robots(lines)

  current_tick = 50000
  max_neighbors = -1
  max_tick = -1
  while current_tick > 0
    puts "Tick [#{current_tick}]"
    new_robots = robots.map { |it| tick(it, current_tick) }

    score = count_num_neighbors(new_robots)
    if score >= max_neighbors
      max_neighbors = score
      max_tick = current_tick
    end
    current_tick -= 1
  end

  puts max_neighbors
  puts "After #{max_tick} ticks"
  display (robots.map { |it| tick(it, max_tick) })
end

main
