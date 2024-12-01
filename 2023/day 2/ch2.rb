
bag = {'red' => 0, 'green'=> 0, 'blue' => 0}
power = []
ans = 0

fileData = File.read('input.txt')

fileData.each_line do |line|

  id_, line = line.split(':')
  line.split(';').each do |r|
    r.split(',').each do |b|
      n, c = b.split

      if n.to_i > bag[c]
        bag[c] = n.to_i
      end
    end
  end

  power << (bag['green'] * bag['red'] * bag['blue'])

  bag = {'red' => 0, 'green'=> 0, 'blue' => 0}
end

puts power.sum
