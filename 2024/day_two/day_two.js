import readData from '../helper/helper.mjs'


const STEP_LIMIT = 3
const test_input = 'test_input.txt'
const input = 'input.txt'

const data = readData(test_input)

const data_state = {}

const convertToNumber = (data) => {
  data = data.trim().split('\n')
  const modify_data = data.map(e => e.split(' '))
  const arr_num = modify_data.map(e => e.map(e => +e))
  return arr_num
}

const arr_num = convertToNumber(data)

const getReportsInitialDirection = (reports) => (reports[1] - reports[0]) > 0 ? 'increasing' : 'decreasing'


const dataInitialDirection = arr_num.map(element => getReportsInitialDirection(element))

const getSafetyStatus = (report, direction) => {
  let status = 'Safe'

  report.forEach((element, indx) => {
    if (!report[indx + 1]) return
    const difference = report[indx + 1] - element

    if (difference > STEP_LIMIT || difference < -STEP_LIMIT || difference === 0) return status = 'Unsafe'
    if (direction === 'increasing' && !( difference > 0)) return status = 'Unsafe'
    if (direction === 'decreasing' && !(difference < 0)) return status = 'Unsafe'
  });
  return status
}

let status = arr_num.map((row, indx) => getSafetyStatus(row, dataInitialDirection[indx]))
let count = 0

const getUnsafeElementIndex = (report, direction) => {
  let unsafe_indx = 0;

  report.forEach((element, index) => {
    if (!report[index + 1]) return
    const difference = report[index + 1] - element

    if (difference > STEP_LIMIT || difference < -STEP_LIMIT || difference === 0) return unsafe_indx = index
    if (direction === 'increasing' && !( difference > 0)) return unsafe_indx = index
    if (direction === 'decreasing' && !(difference < 0)) return unsafe_indx = index
  })


  return unsafe_indx
}

const isRowSafe = (row, direction ) => {
    let status = 'Safe'

  row.forEach((element, indx) => {
    if (!row[indx + 1]) return
    const difference = row[indx + 1] - element

    if (difference > STEP_LIMIT || difference < -STEP_LIMIT || difference === 0) return status = 'Unsafe'
    if (direction === 'increasing' && !(difference > 0)) return status = 'Unsafe'
    if (direction === 'decreasing' && !(difference < 0)) return status = 'Unsafe'
  });
  return status
}





arr_num.forEach((row, index) => {
  if(status[index] === 'Unsafe') {

    const unsafe_index = getUnsafeElementIndex(row, status[index])
    // console.log(unsafe_index)
    const newRow = row.filter((e, indx) => indx != unsafe_index)
    const newRowShiftLeft = row.filter((e, indx) => (indx - 1) != unsafe_index)
    const newRowShiftRight = row.filter((e, indx) => (indx + 1) != unsafe_index)
    const newRowStatus = isRowSafe(newRow, dataInitialDirection[index])
    const newRowShiftLeftStatus = isRowSafe(newRowShiftLeft, dataInitialDirection[index])
    const newRowShiftRightStatus = isRowSafe(newRowShiftRight, dataInitialDirection[index])
    console.log(newRow)
    console.log(newRowShiftLeft)
    console.log(newRowShiftRight)
    if(newRowStatus === 'Safe') status[index] = 'Safe'
    if(newRowShiftLeftStatus === 'Safe') status[index] = 'Safe'
    if(newRowShiftRightStatus === 'Safe') status[index] = 'Safe'
  }
})
status.forEach(e => {if(e === 'Safe') count++})
// console.log(status)
console.log(count)
