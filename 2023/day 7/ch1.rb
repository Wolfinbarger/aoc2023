cardValues = {
  'A' => 14,
  'K' => 13,
  'Q' => 12,
  'J' => 11,
  'T' => 10,
  '9' => 9,
  '8' => 8,
  '7' => 7,
  '6' => 6,
  '5' => 5,
  '4' => 4,
  '3' => 3,
  '2' => 2,
}

typesOfHands = {
  [5] => 7,
  [4, 1] => 6,
  [3, 2] => 5,
  [3, 1, 1] => 4,
  [2, 2, 1] => 3,
  [2, 1, 1, 1] => 2,
  [1,1,1,1,1] => 1,
}

def countCards(cards, typesOfHands)
  type = []
  tmp = cards.chars

  while !tmp.length.zero?
    c = tmp[0]
    type << tmp.count(c)
    tmp.delete(tmp[0])
  end

  typesOfHands[type.sort.reverse]
end

def getType(hands, typesOfHands)
  hands.each do |hand|
    hands[hand[0]].merge!( type: countCards(hand[0], typesOfHands).to_i )
  end
end

def parseHands(fileData)
  fileData.each_with_object({}) do |hand, hash|
    hand, bid = hand.split
    hash[hand] = {bid: bid.to_i}
  end
end

def filterCardsByType(sortedHands, type)
  sortedHands.select do |key, value|
    value[:type] == type
  end
end

def applyRank(cardsOfType, rank, cardValues, sortedHands)
  cardsOfType.each do |e|
    num = 0

    while (num < cardsOfType.length + 1)
      break if cardsOfType[num + 1].nil?

      atCard = cardsOfType[num]
      tmp = cardsOfType[num + 1]

      cardOneChrs = atCard[0].chars
      cardTwoChrs = cardsOfType[num + 1][0].chars

      cardOne = cardOneChrs.map {|c| cardValues[c]}
      cardTwo = cardTwoChrs.map {|c| cardValues[c]}

      step = 0
        while (step < cardOneChrs.length)

          if (cardOne[step] > cardTwo[step])
            cardsOfType[num + 1] = atCard
            cardsOfType[num] = tmp
            step = 100
            break
          elsif (cardOne[step] < cardTwo[step])
            step = 100
            break
          end

          step += 1
        end

      num += 1
    end
  end

  cardsOfType.each_with_index { |c, i| sortedHands[c[0]].merge!(rank: (i + rank + 1)) }
  return [sortedHands, (rank + cardsOfType.length)]
end

def assignRank(sortedHands, cardValues)
  rank = 0

  7.times do |i|
    cardsOfType = filterCardsByType(sortedHands, (i + 1)).to_a

    cardsOfType, rank = applyRank(cardsOfType, rank, cardValues, sortedHands)
  end

  sortedHands
end

def main(cardValues, typesOfHands)
  fileData = File.read('input.txt').split(/\n/)
  hands = parseHands(fileData)

  getType(hands, typesOfHands)
  sortedHands = hands.sort_by { |_, value| value[:type]}.to_h

  rankedCards = assignRank(sortedHands, cardValues)
  rankedCards.each_with_index { |card, i| p "#{i}: #{card}"}

  rankedCards.map { |key| key[1][:bid] * key[1][:rank]}.reduce(:+)
end

p main(cardValues, typesOfHands)
