num_data = []

file_data = File.read('input.txt')

file_data.each_line { |line| num_data << line.delete('/[a-zA-Z]/') }

filter_data = num_data.map { |num| (num.chars.values_at(0, -2).join).to_i }

puts filter_data.sum
