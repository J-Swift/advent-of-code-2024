def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def is_safe?(report)
  is_increasing = nil
  report.reduce do |left, right|
    is_increasing = left > right if is_increasing.nil?
    return false if is_increasing != left > right

    delta = (left - right).abs
    return false if delta < 1 || 3 < delta
    right
  end
  true
end

def main
  lines = parse_input(load_input)

  reports = lines.map { |line| line.split.map(&:to_i) }
  puts reports.select { |it| is_safe?(it) }.count
end

main
