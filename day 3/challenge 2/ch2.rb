# number must be adjacent to a symbol, (.) are not symbols
# adjacent means surrounding area both sides and vertical

# thoughts is a matrix will be easier to check for surrounding area
# lines are 141 characters long (includes escape), 140 without
# total of 140 lines
ans = []
$matrix = []
symLocation = []
fileData = File.read('input.txt')

def checkLeft(row, col)
  num = []
  col = col - 1
  while $matrix[row][col].match?(/\d/)
    num.push($matrix[row][col].to_i)
    col -= 1
  end
  num.reverse.join
end

def checkRight(row, col)
  num = []
  col = col + 1
  while !($matrix[row][col].nil?) && $matrix[row][col].match?(/\d/)
    num.push($matrix[row][col].to_i)
    col += 1
  end
  num.join
end

def checkTop(row, col)
  num = ''
  row = row - 1
 if $matrix[row][col].match?(/\d/)
  num = checkLeft(row, col) + $matrix[row][col] + checkRight(row, col)
 end
 num
end

def checkBottom(row, col)
  num = ''
  row = row + 1
 if $matrix[row][col].match?(/\d/)
  num = checkLeft(row, col) + $matrix[row][col] + checkRight(row, col)
 end
 num
end

def checkTopLeft(row, col)
  num = ''
  col = col
  row = row - 1
  if $matrix[row][col].match?(/\./)
    num = checkLeft(row, col)
  end
  num
end

def checkTopRight(row, col)
  num = ''
  col = col
  row = row - 1
  if $matrix[row][col].match?(/\./)
    num = checkRight(row, col)
  end
  num
end

def checkBottomLeft(row, col)
  num = ''
  col = col
  row = row + 1
  if $matrix[row][col].match?(/\./)
    num = checkLeft(row, col)
  end
  num
end

def checkBottomRight(row, col)
  num = ''
  col = col
  row = row + 1
  if $matrix[row][col].match?(/\./) && !($matrix[row][col].nil?)
    num = checkRight(row, col)
  end
  num
end

def findNumbers(row, col)
  ans = []
  ans << checkLeft(row, col).to_i
  ans << checkRight(row, col).to_i
  ans << checkTop(row , col).to_i
  ans << checkBottom(row, col).to_i
  ans << checkTopLeft(row, col).to_i
  ans << checkTopRight(row, col).to_i
  ans << checkBottomLeft(row, col).to_i
  ans << checkBottomRight(row, col).to_i
  ans
end

# create matrix
fileData.each_line do |line|
  line.chomp!
  $matrix << line.chars
end

# find number(s)
$matrix.each_with_index do |row, n|
  row.each_with_index do |e, j|
    if e.match?(/\*/)
      ans += findNumbers(n, j)
    end
  end
end

p ans .reject { |n| n.zero? }.sum
