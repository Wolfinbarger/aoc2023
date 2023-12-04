cards = {}
ans = 0
fileDataTest = File.open('input.txt')

# def getPoints()
fileDataTest.each_line do |line|
  sum = 1

  id_, card = line.chomp!.split(':')
  winningNums, myNums = card.split('|')

  cards[id_.split()[-1]] = {}

  winningNums.split.each { |wNum| cards[id_.split()[-1]][wNum] = 0 }

  myNums.split.each do |mNum|
    cards[id_.split()[-1]][mNum] =+ 1 if cards[id_.split()[-1]].key?(mNum)

  end
  n = 1
  cards[id_.split()[-1]][:total] = cards[id_.split()[-1]].values.sum

  t = cards[id_.split()[-1]][:total]
  (t - 1).times do
    sum += 2 ** (n - 1)
    n += 1
  end

  ans += sum if !cards[id_.split()[-1]][:total].zero?

end
p ans
