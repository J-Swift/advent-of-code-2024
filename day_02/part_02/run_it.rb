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
  safe = reports.select do |report|
    if is_safe?(report)
      true
    else
      report.count.times.any? do |index|
        sliced = report[0...index] + report[index+1...]
        is_safe?(sliced)
      end
    end
  end
  puts safe.count
end

main
