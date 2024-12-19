def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def main
  lines = parse_input(load_input)

  res_left, res_right = [], []
  counts_right = Hash.new { 0 }
  lines.each_with_index do |line, idx|
    res_left[idx], res_right[idx] = line.split.map(&:to_i)
    counts_right[res_right[idx]] += 1
  end

  puts res_left.reduce(0) { |memo, left| memo + (left * counts_right[left]) }
end

main
