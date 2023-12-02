# only 12 reds, 13 greens, 14 blues
sum = 0
fileData = File.read('input.txt')

fileData.each_line do |line|
  id_, line = line.split(':')

  if !(line.match?(/([2-9][0-9])|(1[5-9])|([1-9][4-9]\sgreen)|([1][3-9]\sred)/))
    sum += id_.split()[-1].to_i
  end
end
puts sum
