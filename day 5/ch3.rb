fileData = File.read('input.txt').split(/\n\n/)

seeds = fileData.shift().split(": ")[1].split.map(&:to_i).each_slice(2).to_a

def createRange(line)
  items = line.split

  return {
    dest: items[0].to_i,
    src: items[1].to_i,
    range: items[2].to_i,
  }
end

def parseMap(fileData)
  data = fileData.split(/\n/)
  from, _, to = data.shift().split(':')[0].split()[0].split('-')

  return {
      from: from,
      to: to,
      map: data.map { |x| createRange(x) }
    }

end

def getLocation(value, name, map)

  return value if map.find { |e| e[name]}.nil?

  item = map.find { |e| e[name]}

  range = item[name][:map].find { |x| x[:src] <= value && value <= x[:src] + x[:range] }


  if (!range.nil?)
    newValue = range[:dest] + (value - range[:src])
    return getLocation(newValue, item[name][:to], map)
  end

  return getLocation(value, item[name][:to], map)
end

maps = fileData.map { |x| parseMap(x) }

parsedMaps = maps.map do |hash|
  { hash[:from] => hash }
end

minLocation = nil
seeds.each do |seeds|
  (seeds[0]..(seeds.sum)).each do |seed|

    location = getLocation(seed, 'seed', parsedMaps)
    ( minLocation.nil? || location < minLocation  ) ? minLocation = location : minLocation
    puts "Seeds: #{seeds}; Seed: #{seed}; Min: #{minLocation}"
  end

end
p minLocation
