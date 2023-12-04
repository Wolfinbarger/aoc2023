ans = 0

fileDataTest = File.open('input.txt')

fileDataTest.each_line do |line|
  points = 1
  n = 1

  id_, card = line.chomp!.split(':')
  winningNums, myNums = card.split('|')

  matches = (winningNums.split() & myNums.split()).length

  (matches - 1).times do
    points += 2 ** (n - 1)
    n += 1
  end

  ans += points if matches != 0

end

p ans
