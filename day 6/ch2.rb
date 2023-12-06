time, distance = File.read('input.txt').split(/\n/).map { |ele| ele.split(':')[1].delete(' ').to_i }


def binarySearch(time, mid, distance)
  mid.times do |i|
    if ((time - i) * i ) > distance
      return time.odd? ? (mid - i) * 2 : (((mid  - i) * 2) - 1)
    end
  end
end

def getCombos(time, distance)

  length = time + 1
  midPoint = (length % 2).zero? ? length / 2 : length / 2 + 1
  mid = ( midPoint % 2).zero? ? midPoint / 2 : midPoint / 2 + 1
  binarySearch(time, midPoint, distance)
end

p getCombos(time, distance)
