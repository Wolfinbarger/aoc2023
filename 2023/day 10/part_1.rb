# frozen_string_literal: true

set_file = 0

PIPES = {
  "|" => %w[north south],
  "-" => %w[east west],
  "L" => %w[north east],
  "J" => %w[north west],
  "7" => %w[south west],
  "F" => %w[south east],
  0 => "start",
}.freeze

def main(set_file, pipes)
  original_map = (set_file.zero? ? parse_file("test.txt") : parse_file("input.txt"))
  print_map(original_map, "Map")
  found_start = find_start(original_map)
  start_map = change_start_location(original_map, found_start)
  print_map(start_map, "Start")
  ground_map = change_ground(start_map)
  print_map(ground_map, "Ground")
  walked_map = walk_map(ground_map, ground_map, pipes, found_start)
  # print_map(walked_map, "Walk")
end

def parse_file(file_name)
  File.readlines(file_name).map { |line| line.gsub(/\n/, " ").chars }
end

def print_map(map, name)
  p name
  map.each do |row|
    row.each { |element| print "#{element} " }
    puts
  end
  puts
end

def find_start(map)
  map.each_with_index { |row, index| return [index, row.find_index("S")] unless row.find_index("S").nil? }
end

def change_start_location(map, found_start)
  map[found_start[0]][found_start[1]] = 0
  map
end

def change_ground(map)
  map.map do |row|
    row.map { |element| element == "." ? " " : element }
  end
end

def walk_map(original_map, modify_map, pipes, position)
  p pipe?(map[2][1], pipes)
end

# def walk_north(map, point, step)
#   return map if map[point].nil? || !pipe?(point)

#   next_point = [point[0] , point[1] - 1]

#   pipe?(next_point)
# end

# def walk_south(map, point, step)
#   return map if map[point].nil? || !pipe?(point)

#   next_point = [point[0] , point[1] + 1]

#   pipe?(next_point)
# end

# def walk_west(map, point, step)
#   return map if map[point].nil? || !pipe?(point)

#   next_point = [point[0] - 1 , point[1]]

#   pipe?(next_point)
# end

# def walk_east(map, point, step)
#   return map if map[point].nil? || !pipe?(point)

#   next_point = [point[0] + 1, point[1]]

#   pipe?(next_point)
# end

def pipe?(position, pipes)
  pipes.key?(position)
end

def connected?(pipe, next_pipe, traverse_direction)
  case pipe.to_s
  when "0" then true
  when "|"
    return true if (traverse_direction.match?("north") && next_pipe.match?(/F|7|\|/)) || (traverse_direction.match?("south") && next_pipe.match?(/\||L|J/))
  when "-"
    return true if (traverse_direction.match?("west") && next_pipe.match?(/-|L|F/)) || (traverse_direction.match?("east") && next_pipe.match?(/-|J|7/))
  when "L"
    return true if (traverse_direction.match?("north") && next_pipe.match?(/F|7|\|/)) || (traverse_direction.match?("east") && next_pipe.match?(/-|J|7/))
  when "J"
    return true if (traverse_direction.match?("north") && next_pipe.match?(/F|7|\|/)) || (traverse_direction.match?("west") && next_pipe.match?(/-|L|F/))
  when "7"
    return true if (traverse_direction.match?("south") && next_pipe.match?(/\||L|J/)) || (traverse_direction.match?("west") && next_pipe.match?(/-|L|F/))
  when "F"
    return true if (traverse_direction.match?("south") && next_pipe.match?(/\||L|J/)) || (traverse_direction.match?("east") && next_pipe.match?(/-|J|7/))
  else
    false
  end
end

main(set_file, PIPES)
