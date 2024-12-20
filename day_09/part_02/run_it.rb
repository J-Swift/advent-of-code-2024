def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

Block = Struct.new(:is_file, :size, :file_id) do
  def expanded
    if is_file
      [file_id] * size
    else
      ["."] * size
    end
  end

  def to_s
    "<B [#{is_file ? 'f' : 's'}] [#{size}] [#{file_id}]>"
  end
end

def checksum(result)
  str_result = result.map(&:expanded).flatten
  str_result.each_with_index.reduce(0) do |memo, (id, idx)|
    id = 0 if id == "."
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
      res.push(Block.new(true, it.to_i, file_id))
      file_id += 1
    else
      res.push(Block.new(false, it.to_i, nil))
    end
    is_file = !is_file
  end

  new_res = []

  while res.size > 0
    r_block = res.last
    if !r_block.is_file
      new_res.unshift(res.pop)
      next
    end

    found, found_idx = res.each_with_index.find do |it, idx|
      !it.is_file && it.size >= r_block.size
    end

    if !found
      new_res.unshift(res.pop)
    else
      idx = found_idx
      if found.size == r_block.size
        new_res.unshift(Block.new(false, r_block.size, nil))
      else
        new_res.unshift(Block.new(false, r_block.size, nil))
        res.insert(idx+1, Block.new(false, found.size - r_block.size))
      end
      res[idx] = r_block
      res.pop
    end
  end

  puts checksum(new_res)
end

main
