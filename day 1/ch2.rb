num = { '1' => "one",
        '2' => "two",
        '3' => "three",
        '4' => "four",
        '5' => "five",
        '6' => "six",
        '7' => "seven",
        '8' => "eight",
        '9' => "nine",
        'eno' => '1',
        'owt' => '2',
        'eerht' => '3',
        'ruof' => '4',
        'evif' => '5',
        'xis' => '6',
        'neves' => '7',
        'thgie' => '8',
        'enin' => '9',
        "one" => '1',
        "two" => '2',
        "three" => '3',
        "four" => '4',
        "five" => '5',
        "six" => '6',
        "seven" => '7',
        "eight" => '8',
        "nine" => '9',
      }

num_data = []
newLine = []
nums = []

file_data = File.read('input.txt')

file_data.each_line { |line| num_data << line.scan(/([1-9]|(oneight)|(twone)|(threeight)|(fiveight)|(sevenine)|(eightwo)|(eighthree)|(nineight)|(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine))/).join(' ') }

num_data.each { |word| newLine << (word.split.first + " " + word.split.last) }

newLine.each_with_index { |line, idx| puts "#{idx}: #{line}" }

newLines = newLine.map do |line|
  line = line.split
  subt = line[0].scan(/([1-9]|(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)){1}/)

  line[0] = subt[0][0]

  subtt = (line[1].reverse.scan(/([1-9]|(eno)|(owt)|(eerht)|(ruof)|(evif)|(xis)|(neves)|(thgie)|(enin))/)).reverse
  subtt = subtt.flatten

  line[1] = subtt[0]

  line.join(' ')
end


nums = newLines.map do |line|
  line = line.split

  if !(line.first.match(/[1-9]/)) then line[0] = num.key(line[0]) end
  if !(line.last.match(/[1-9]/)) then line[-1] = num.fetch(line[-1]) end
  line.join.to_i
end

puts nums.sum
