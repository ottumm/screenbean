screenbean = require './screenbean'
program = require 'commander'
fs = require 'fs'

program
  .option('-i --input [file]', 'Input file (.fountain). <stdin> will be used if no input file is specified.')
  .option('-o --output [file]', 'Output file (.html). <stdout> will be used if no output file is specified.')
  .parse(process.argv)

handleText = (text) ->
  screenbean.parse text, (err, html) ->
    throw err if err;
    
    if program.output
      fs.writeFile program.output, html, {encoding: 'utf8'}, (err) ->
        throw err if err;
    else
      console.log html

if program.input
  console.dir program.input
  fs.readFile program.input, {encoding: 'utf8'}, (err, data) ->
    throw err if err;
    handleText data
else
  process.stdin.setEncoding 'utf8'
  chunks = []
  process.stdin.on 'readable', () ->
    chunk = process.stdin.read()
    if chunk != null
      chunks.push chunk
  
  process.stdin.on 'end', () ->
    handleText chunks.join('')
