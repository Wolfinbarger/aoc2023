ans = 0
cards = {}
fileDataTest = File.open('input.txt')

fileDataTest.each_line do |line|
  id_, card = line.chomp!.split(':')
  winningNums, myNums = card.split('|')
  matches = (winningNums.split() & myNums.split()).length
  cards[id_.split()[-1].to_i] = { :matches => matches, :count => 1,  }
end

cards.each_pair do |key, pair|

  (1..pair[:count]).each do |i|
    (1..pair[:matches]).each do |n|
      cards[(key + n)][:count] += 1
    end
  end

end

cards.values.map { |n| ans += n[:count]}
p ans
