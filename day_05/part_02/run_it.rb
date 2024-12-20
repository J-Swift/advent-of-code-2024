def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

def order_it(numbers, rules_before)
  numbers.sort do |a, b|
    case
    when rules_before[a].member?(b)
      -1
    when rules_before[b].member?(a)
      1
    else
      0
    end
  end
end

def main
  lines = parse_input(load_input)

  rules_before = Hash.new { Set.new }
  updates = []

  is_parsing_rules = true
  lines.each do |line|
    if line.empty?
      is_parsing_rules = false
      next
    end

    if is_parsing_rules
      page_a, page_b = line.split('|').map(&:to_i)
      rules_before[page_a] = rules_before[page_a].add(page_b)
    else
      updates << line.split(',').map(&:to_i)
    end
  end

  bad_res = updates.reject do |update|
    seen = Set.new
    valid = true
    update.each do |page_number|
      next unless valid
      must_come_before = rules_before[page_number]
      if must_come_before.any? { |it| seen.member?(it) }
        valid = false
      end
      seen.add(page_number)
    end
    valid
  end

  res = bad_res.each_with_index.map do |bad_update, idx|
    order_it(bad_update, rules_before)
  end

  puts res.map { |it| it[it.count / 2]}.sum
end

main
