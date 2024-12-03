import * as fs from 'fs'

const readData = (input) =>
  {
  return fs.readFileSync(input, 'utf8', (err, data) => {
                                                        if (err) throw err;
                                                        return data.trim()
          })
        }

export default readData
