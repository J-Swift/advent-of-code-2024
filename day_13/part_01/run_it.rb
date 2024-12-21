def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

Config = Struct.new(:ax, :ay, :bx, :by, :prizex, :prizey)

def parse_configs(lines)
  button_re = /X\+(\d+), Y\+(\d+)/
  prize_re = /X=(\d+), Y=(\d+)/
  configs = []
  idx = 0
  while idx < lines.length
    a_config = lines[idx].scan(button_re)[0].map(&:to_i)
    b_config = lines[idx+1].scan(button_re)[0].map(&:to_i)
    prize_config = lines[idx+2].scan(prize_re)[0].map(&:to_i)
    configs << Config.new(a_config[0], a_config[1], b_config[0], b_config[1], prize_config[0], prize_config[1])
    idx+=4
  end
  configs
end

def optimize_config(config)
  # a_cost, b_cost = 3, 1

  max_b_x = config.prizex / config.bx
  max_b_y = config.prizey / config.by

  total_bs = [max_b_x, max_b_y, 100].min
  while total_bs >= 0
    total_bx = config.bx * total_bs
    total_by = config.by * total_bs

    prize_rem_x = config.prizex - total_bx
    prize_rem_y = config.prizey - total_by

    total_ax = prize_rem_x / config.ax
    total_ay = prize_rem_y / config.ay

    if (total_ax * config.ax == prize_rem_x) &&  (total_ay * config.ay == prize_rem_y) && total_ax == total_ay && total_ax <= 100
      return [total_ax, total_bs]
    end

    total_bs -= 1
  end

  nil
  # raise "Cant solve config [#{config}]"
end

def cost_for_solution(solution)
  a, b = solution

  a * 3 + b
end

def main
  lines = parse_input(load_input)

  configs = parse_configs(lines)

  configs.map do |config|
    optimize_config(config)
    # puts '-----------'
    # puts "Config : #{config}"
    # pp res
    # puts cost_for_solution(res) if res
  end.compact.sum { |it| cost_for_solution(it) }.tap { |it| puts it }
  # pp configs
end

main
