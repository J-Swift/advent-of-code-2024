def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

Robot = Struct.new(:px, :py, :vx, :vy)
BOARD_W = 101
BOARD_H = 103
# BOARD_W = 11
# BOARD_H = 7

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

def main
  lines = parse_input(load_input)

  robots = parse_robots(lines)
  # pp robots

  new_robots = robots.map { |it| tick(it, 100) }

  midx = (BOARD_W.to_r-1) / 2r
  midy = (BOARD_H.to_r-1) / 2r

  tl = new_robots.reduce(0) do |memo, robot|
    (robot.px < midx && robot.py < midy) ? memo + 1 : memo
  end
  tr = new_robots.reduce(0) do |memo, robot|
    (robot.px > midx && robot.py < midy) ? memo + 1 : memo
  end
  bl = new_robots.reduce(0) do |memo, robot|
    (robot.px < midx && robot.py > midy) ? memo + 1 : memo
  end
  br = new_robots.reduce(0) do |memo, robot|
    (robot.px > midx && robot.py > midy) ? memo + 1 : memo
  end

  puts "[tl #{tl}] [tr #{tr}] [bl #{bl}] [br #{br}]"
  puts tl * tr * bl * br
end

main
