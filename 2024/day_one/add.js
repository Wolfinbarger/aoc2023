const fs = require('fs')

const data = fs.readFileSync('input_1.txt', 'utf8', (err, data) => {
  if (err) throw err;
  return data
})

const dataContent = data.trim().replaceAll('\n', '  ').split('  ')

console.log(dataContent)

let count = 0;
let a1 = []
let a2 = []

for(let i = 0; i < dataContent.length; i+=2) {
  a1.push(+dataContent[i])
  a2.push(+dataContent[i+1])
}

a1 = a1.sort()
a2 = a2.sort()


// for(let i = 0; i < a1.length; i++) {
//   count += Math.abs(a1[i] - a2[i])
// }

a1.forEach(e => {
  const r = a2.filter((e2) => e2 === e).length
  count += +e * r
})
console.log(count)
