def traverse(instructions, network, node, step, count)

  while !node[1][:currentNode].end_with?('Z')
    count += 1
    direction = instructions[step]

    currentNode = network[node[1][:currentNode]][direction.to_sym]
    node[1][:currentNode] = currentNode
    (step == instructions.length - 1) ? step = 0 : step += 1
  end
  count
end

def buildNode(node)
  node.each_with_object({}) do |node, hash|
    point = node[0].strip
    left = node[1].strip
    right = node[2].strip
    hash[point] = { "L": left, "R": right }
  end
end

def buildNetwork(parsedNetwork)
  network = parsedNetwork.map do |node|
    point = node[0]
    right = node[1][1]
    left = node[1][0]
    [point, left, right]
  end

  midBuild =  buildNode(network)
end


def parseNetwork(network)
  pointInstructions = network.split(/\n/)

  pointRelationship = pointInstructions.map { |point| point.split('=') }

  parsePointRelationship = pointRelationship.map do |point|
    relationship = point[1].delete('/\(|\)/').split(',')
    [point[0], relationship]
  end

  parsePointRelationship
end

def readFile()
  File.read('input.txt').split(/\n\n/)
end


def main
  counts = []
  navigationInstructions, network =  readFile()
  parsedNetwork = parseNetwork(network)
  network =  buildNetwork(parsedNetwork)

  endWithAKeys = network.select { |hash| hash.match(/(..A)/) }
  startNodes = endWithAKeys.each { |key, value| value[:currentNode] = key}

  startNodes.each { |node| counts << traverse(navigationInstructions.chars, network, node, 0, 0)}

  counts.reduce(1, :lcm)
end

p main()
# LCM find starts each count to "..Z"
