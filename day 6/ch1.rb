times, distances = File.read('input.txt').split(/\n/).map { |ele| ele.split(':')[1].split.map(&:to_i) }

def binarySearch(time, mid, distance)
  mid.times do |i|
    if ((time - i) * i ) > distance
      return time.odd? ? (mid - i) * 2 : (((mid  - i) * 2) - 1)
    end
  end
end

def getCombos(times, distances)
  combos = []
  times.each_with_index do |time, index|
    length = time + 1
    midPoint = (length % 2).zero? ? length / 2 : length / 2 + 1
    mid = ( midPoint % 2).zero? ? midPoint / 2 : midPoint / 2 + 1
    combos << binarySearch(time, midPoint, distances[index])
  end
  combos
end

p getCombos(times, distances).reduce(:*)
