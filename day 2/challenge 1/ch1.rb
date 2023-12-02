# only 12 reds, 13 greens, 14 blues

bag = {'red' => 12, 'green'=> 13, 'blue' => 14}
ans = 0

fileData = File.read('input.txt')

fileData.each_line do |line|
  ok = true
  id_, line = line.split(':')
  line.split(';').each do |r|
    r.split(',').each do |b|
      n, c = b.split

      if n.to_i > bag[c]
        ok = false
      end
    end
  end
  if ok
    ans += id_.split()[-1].to_i
    puts id_
  end
end
puts ans
