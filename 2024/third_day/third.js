import readData from '../helper/helper.mjs'

const TEST_INPUT = 'test_input.txt'
const INPUT = 'input.txt'

const data = readData(TEST_INPUT)

const rs = 'mul\\(\\\d{1,3},\\\d{1,3}\\)'

const rsDoDont = '(do\\(\\))|(don\'t\\(\\))'

const findDoDont = (data) => {
  const filterData = data.matchAll(rsDoDont)
  const matches = Array.from(filterData)
  return matches
}

const findValidMul = (data) => {
  const filterData = data.matchAll(rs)
  const matches = Array.from(filterData)
  return matches.map(match => match[0])
}

const trimMulCall = (muls) => {
  return muls.map(mul => mul.replace('mul(', '').replace(')', ''))
}

const multiply = (muls) => {
  return muls.map(mul => {
      const [x, y] = mul.split(',')
      return x * y
    })

}

const sum = (nums) => {
  return nums.reduce((acc,cur) => acc + cur)
}

const validMul = findValidMul(data)

const trimMuls = trimMulCall(validMul)

const nums = multiply(trimMuls)

const answer = sum(nums)
// console.log(answer)

console.log(findDoDont(data))

// console.log(data)
