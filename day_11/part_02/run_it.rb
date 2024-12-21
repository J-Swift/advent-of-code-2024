def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines[0].split(' ').map(&:to_i)
end

def blink(memoized_stones)
  res = Hash.new { 0 }
  memoized_stones.each do |stone, count|
    if stone == 0
      res[1] += count
    elsif stone.to_s.length % 2 == 0
      str = stone.to_s
      res[str[0..(str.length/2-1)].to_i] += count
      res[str[(str.length-1)/2+1..].to_i] += count
    else
      res[2024 * stone] += count
    end
  end
  res
end

def main
  stones = parse_input(load_input)

  memoized_stones = Hash.new { 0 }
  stones.each do |stone|
    memoized_stones[stone] += 1
  end

  75.times do |i|
    memoized_stones = blink(memoized_stones)
  end

  res = memoized_stones.reduce(0) do |memo, (k, v)|
    memo + v
  end
  puts res
end

main
