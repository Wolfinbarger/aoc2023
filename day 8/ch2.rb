def endWithZ(startNodes, key)
  valuesAtKey = startNodes.values.map { |value| value[key.to_sym]}
  valuesAtKey.all? { |value| value.end_with?("Z")}
end

def changeValue(network, hash, key, direction)
  n = 0

  hash.each do |k, v|
    oldCurrentNode = v[key.to_sym]
    traverseNode = network[oldCurrentNode]
    nextCurrentNode = traverseNode[direction.to_sym]
    v[key.to_sym] = nextCurrentNode
  end
end

def traverse(instructions, network, startNodes, step, count)

  while endWithZ(startNodes, "currentNode") != true
    count += 1
    direction = instructions[step]


    startNodes = changeValue(network, startNodes, 'currentNode', direction)



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
  navigationInstructions, network =  readFile()
  parsedNetwork = parseNetwork(network)
  network =  buildNetwork(parsedNetwork)

  endWithAKeys = network.select { |hash| hash.match(/(..A)/) }
  startNodes = endWithAKeys.each { |key, value| value[:currentNode] = key}

  # p endWithZLefts = network.select {|_, directions| directions[:L].match(/(..Z)/) }.count
  # p endWithZRight = network.select {|_, directions| directions[:R].match(/(..Z)/) }.count
  count = traverse(navigationInstructions.chars, network, startNodes, 0, 0)
  p count
end

main()
# brute force
