def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

class Tokenizer
  def self.tokenize(str)
    cur_idx = 0
    tokens = []

    while cur_idx < str.size
      substr = str[cur_idx..]
      if substr.start_with?(DO_REGEX)
        tokens << [:do]
        cur_idx += 4
      elsif substr.start_with?(DONT_REGEX)
        tokens << [:dont]
        cur_idx += 7
      elsif substr.start_with?(MUL_REGEX)
        match = substr.match(MUL_REGEX)
        tokens << [:mul, match[1].to_i, match[2].to_i]
        cur_idx += 6 + match[1].size + match[2].size
      else
        cur_idx += 1
      end
    end

    tokens
  end
end

MUL_REGEX = /mul\((\d+),(\d+)\)/
DO_REGEX = /do\(\)/
DONT_REGEX = /don't\(\)/

def main
  lines = parse_input(load_input)

  tokens = []
  lines.each do |line|
    tokens.concat(Tokenizer.tokenize(line))
  end
  res = 0
  should_mul = true
  tokens.each do |(token, a, b)|
    next if should_mul == false && token != :do
    
    case token
    when :do
      should_mul = true
    when :dont
      should_mul = false
    when :mul
      res += a * b
    else
      raise "Invalid token [#{token}]"
    end
  end
  puts res
end

main
