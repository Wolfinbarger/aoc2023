# polynomial interpolation
set_file = 1

def main(set_file)
  file_name = set_file.zero? ? 'test.txt' : 'input.txt'

  data_set =  parse_file(file_name)

  all_sequences_extrapolate = get_all_extrapolations(data_set)
  p all_sequences_extrapolate.reduce(:+)
end

def parse_file(file_name)
    file_data = File.read(file_name)
    pase_data = file_data.split(/\n/).map { |line| line.split.map {|number| number.to_i } }
end

def get_all_extrapolations(data_set)
  data_set.map do |data|
    get_extrapolation(data)
  end
end

def get_extrapolation(data)
  data_differences = differences_till_zero(data, []).reverse
  find_extapolates(data_differences)
end

def differences_till_zero(data, differences_array)
  return differences_array << data.push(0) if data.all?(0)

  differences_array << data

  difference = data.each_with_index.map do |current_value, index|
    data[index + 1] - current_value unless index == data.length - 1
  end

  differences_till_zero(difference.compact, differences_array)
end

def find_extapolates(data_differences)
  value = data_differences.each_with_index do |array, index|
              data_differences[index + 1].push( array.last + data_differences[index + 1].last) unless index == data_differences.length - 1
           end
  value.last.last
end

main(set_file)
