# polynomial interpolation
set_file = 1
historic = true

def main(set_file, historic)
  file_name = set_file.zero? ? 'test.txt' : 'input.txt'

  data_set =  parse_file(file_name)

  all_sequences_extrapolate = get_all_extrapolations(data_set, historic)
  p all_sequences_extrapolate.reduce(:+)
end

def parse_file(file_name)
    file_data = File.read(file_name)
    pase_data = file_data.split(/\n/).map { |line| line.split.map {|number| number.to_i } }
end

def get_all_extrapolations(data_set, historic)
  data_set.map do |data|
    get_extrapolation(data, historic)
  end
end

def get_extrapolation(data, historic)
  data_differences = differences_till_zero(data, []).reverse
  find_extrapolates(data_differences, historic)
end

def differences_till_zero(data, differences_array)
  return differences_array << data.push(0) if data.all?(0)


  differences_array << data

  difference = data.each_with_index.map do |current_value, index|
    data[index + 1] - current_value unless index == data.length - 1
  end

  differences_till_zero(difference.compact, differences_array)
end

def find_extrapolates(data_differences, historic)
  value = data_differences.each_with_index do |array, index|
              case historic
              when false then data_differences[index + 1].push( array.last + data_differences[index + 1].last) unless index == data_differences.length - 1
              when true then data_differences[index + 1].insert(0, (data_differences[index + 1].first - array.first )) unless index == data_differences.length - 1
              end
           end
  historic == false ? value.last.last : value.last.first
end

main(set_file, historic)
