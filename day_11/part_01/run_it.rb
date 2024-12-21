def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines[0].split(' ').map(&:to_i)
end

def blink(stones)
  res = []
  stones.each do |stone|
    if stone == 0
      res << 1
    elsif stone.to_s.length % 2 == 0
      str = stone.to_s
      res << str[0..(str.length/2-1)].to_i
      res << str[(str.length-1)/2+1..].to_i
    else
      res << 2024 * stone
    end
  end
  res
end

def main
  stones = parse_input(load_input)

  25.times do
    stones = blink(stones)
  end
  puts stones.count
end

main
