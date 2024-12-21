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
    configs << Config.new(a_config[0], a_config[1], b_config[0], b_config[1], prize_config[0]+10000000000000, prize_config[1]+10000000000000)
    idx+=4
  end
  configs
end

def solve_matrix(config)
  # irb(main):001:0> ax = 26r
  # irb(main):002:0> ay = 67r
  # irb(main):003:0> x = 10000000012748r
  # irb(main):004:0> bx = 66r
  # irb(main):005:0> by = 21r
  # irb(main):006:0> y = 10000000012176r
  ax = config.ax.to_r
  ay = config.bx.to_r
  x = config.prizex.to_r
  bx = config.ay.to_r
  by = config.by.to_r
  y = config.prizey.to_r


  # irb(main):015:0> mul = (bx/ax)
  # irb(main):024:0> bx = bx - mul*ax
  # irb(main):025:0> by = by - mul*ay
  # irb(main):027:0> y = y - mul*x
  mul = (bx/ax)
  bx = bx - mul*ax
  by = by - mul*ay
  y = y - mul*x

  # irb(main):029:0> puts ax, ay, x
  # 26/1
  # 67/1
  # 10000000012748/1
  # => nil
  # irb(main):030:0> puts bx, by, y
  # 0/1
  # -1938/13
  # -200000000262396/13
  # => nil

  # irb(main):031:0> div = by
  # irb(main):032:0> bx = bx / div
  # irb(main):033:0> by = by / div
  # irb(main):034:0> y = y / div
  div = by
  bx = bx / div
  by = by / div
  y = y / div

  # irb(main):035:0> puts ax, ay, x
  # 26/1
  # 67/1
  # 10000000012748/1
  # => nil
  # irb(main):036:0> puts bx, by, y
  # 0/1
  # 1/1
  # 103199174542/1
  # => nil

  # irb(main):038:0> mul = ay / by
  # irb(main):041:0> ax = ax - mul*bx
  # irb(main):042:0> ay = ay - mul*by
  # irb(main):043:0> x = x - mul*y
  mul = ay / by
  ax = ax - mul*bx
  ay = ay - mul*by
  x = x - mul*y

  # irb(main):044:0> puts ax, ay, x
  # 26/1
  # 0/1
  # 3085655318434/1
  # => nil

  # irb(main):045:0> x = x / ax
  # => (118679050709/1)
  # irb(main):046:0> ax = ax / ax
  # => (1/1)
  x = x / ax
  ax = ax / ax

  # irb(main):047:0> puts ax, ay, x
  # 1/1
  # 0/1
  # 118679050709/1
  # => nil
  # irb(main):048:0> puts bx, by, y
  # 0/1
  # 1/1
  # 103199174542/1
  # => nil

  x.denominator == 1 && y.denominator == 1 ? [x.numerator, y.numerator] : nil
end

def cost_for_solution(solution)
  a, b = solution

  a * 3 + b
end

def main
  lines = parse_input(load_input)

  configs = parse_configs(lines)

  configs.map do |config|
    solve_matrix(config)
  end.compact.sum { |it| cost_for_solution(it) }.tap { |it| puts it }
end

main
