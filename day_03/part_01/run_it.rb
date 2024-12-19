def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

MUL_REGEX = /mul\((\d+),(\d+)\)/
def main
  lines = parse_input(load_input)

  hits = []
  lines.each do |line|
    hits.concat(line.scan(MUL_REGEX))
  end
  res = hits.reduce(0) do |memo, (a, b)|
    memo + a.to_i * b.to_i
  end
  puts res
end

main
