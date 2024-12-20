def load_input
  File.readlines('input.txt').map(&:strip)
end

def parse_input(lines)
  lines
end

OPS = [:+, :*, :concat]

def operator_combinations(operators, num_required)
  op_count = operators.count
  Enumerator.new do |y|
    (op_count**num_required).times do |iter|
      denom = 1
      idxs = [(iter/denom) % op_count]
      (num_required-1).times do
        denom *= op_count
        idxs << (iter/denom) % op_count
      end

      y << idxs.map { |idx| operators[idx] }
    end
  end
end

def apply_operator(number1, number2, operator)
  case operator
  when :+ then number1 + number2
  when :* then number1 * number2
  when :concat
    num_digits = number2.to_s.length
    number1*(10 ** num_digits) + number2
  else raise "Unknown operator [#{operator}]"
  end
end

def result_for(numbers, operators)
  raise "Invalid counts" unless (numbers.length == operators.length + 1)

  current_num_idx = 2
  current_op_idx = 1
  current_result = apply_operator(numbers[0], numbers[1], operators[0])
  while current_op_idx < operators.length
    current_result = apply_operator(current_result, numbers[current_num_idx], operators[current_op_idx])
    current_num_idx += 1
    current_op_idx += 1
  end

  current_result
end

def solve_case(test_case)
  target, numbers = test_case[0], test_case[1]

  count = numbers.count - 1

  operator_combinations(OPS, count).each do |operators|
    result = result_for(numbers, operators)
    return operators if target == result
  end
  nil
end

def main
  lines = parse_input(load_input)

  test_cases = lines.map do |line|
    numbers = line.scan(/\d+/).map(&:to_i)
    [numbers[0], numbers[1..]]
  end

  total_count = test_cases.count
  current_count = 0

  res = test_cases.filter do |test_case|
    current_count+= 1
    solve_case(test_case) != nil
  end

  puts res.map { |it| it[0] }.sum
end

main
