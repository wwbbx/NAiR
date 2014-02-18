cp = require 'child_process'
path = require 'path'
fs = require 'fs'

module.exports.npmUpdate = ->
	cp.exec('npm update', (error, stdout, stderr)->
		console.log 'finish updating npm modules.')

module.exports.npmInstall = ->
	cp.exec('npm install', (error, stdout, stderr)->
		console.log 'finish installing npm modules.')

# current directory is __dirname
console.log 'current directory is: ' + __dirname
rootDir = __dirname

# enter AiRService directory to execute npm install
# if "node_modules" exists, we will call npm update
# if "node_modules" not exists, we will call npm install
airServiceDir = path.join(rootDir, 'AiRService')
process.chdir(airServiceDir)

if fs.existsSync('node_modules')
	@npmUpdate()
else
	@npmInstall()


# enter AiR directory
airDir = path.join(rootDir, 'AiR')
process.chdir(airDir)

if fs.existsSync('node_modules')
	@npmUpdate()
else
	@npmInstall()
