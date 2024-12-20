def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def checksum(result)
  result.each_with_index.reduce(0) do |memo, (id, idx)|
    return memo if id == "."
    memo += (id * idx)
  end
end

def main
  lines = parse_input(load_input)[0]

  is_file = true
  file_id = 0
  files = []

  res = []
  lines.split('').each do |it|
    if is_file
      res.concat([file_id] * it.to_i)
      file_id += 1
    else
      res.concat(['.'] * it.to_i)
    end
    is_file = !is_file
  end

  l_ptr = 0
  r_ptr = res.count - 1

  while l_ptr < r_ptr
    l_char = res[l_ptr] 
    while l_char != '.'
      l_ptr += 1
      l_char = res[l_ptr] 
    end

    r_char = res[r_ptr]
    while r_char == '.'
      r_ptr -= 1
      r_char = res[r_ptr]
    end

    res[r_ptr] = '.'
    res[l_ptr] = r_char
    l_ptr += 1
    r_ptr -= 1

    puts "[#{res.count}] [#{l_ptr}] [#{r_ptr}]" if l_ptr % 100 == 0
  end

  puts checksum(res)
end

main
