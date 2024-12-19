def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def main
  lines = parse_input(load_input)

  res_left, res_right = [], []
  lines.each_with_index { |line, idx| res_left[idx], res_right[idx] = line.split.map(&:to_i) }

  res_left.sort!
  res_right.sort!

  puts res_left.zip(res_right).reduce(0) { |memo, (a, b)| memo + (a > b ? a - b : b - a) }
end

main
