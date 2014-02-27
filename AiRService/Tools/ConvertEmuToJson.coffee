# this utility is designed to convert one EMU Test Card to Json format.
# normally one EMU Test Card is files within one folder.
# Its folder path contains family and MUT name information.
# Usage: ConvertEmuToJson <One EMU Test Card Folder> <Output Json File Full Name>

# Requirement: given one EMU Test Card folder, create one JSON file and return
#              its full path.

fs = require('fs')
path = require 'path'

##################################################

ForceOption = false
EmuSourceDir = ""
OutputJsonFile = ""

module.exports.ParseParameter = ()->
	if process.argv.length < 4 then return false

	@EmuSourceDir = process.argv[2]
	@OutputJsonFile = process.argv[3]

	if process.argv.length > 4
		if(process.argv[4] == "-f")
			@ForceOption = true

	return true

module.exports.IsValidEmuTestCardDir = (emuDirName)->
	# must have dsheet.tpe and tcard.tpe
	dsheet = path.join(emuDirName, "dsheet.tpe")
	if ! fs.existsSync(dsheet) then return false

	tcard = path.join(emuDirName, "tcard.tpe")
	if ! fs.existsSync(tcard) then return false

	return true

module.exports.ConvertEmuTestCard = (emuDirName)->
	return "{name:'this is testing'}"

module.exports.GetTempFileName = ()->
	crypto = require 'crypto'
	os = require 'os'
	fileName = crypto.randomBytes(4).readUInt32LE(0).toString()
	return path.join(os.tmpdir(), fileName)

module.exports.SaveFileContent = (fileName, content)->
	fs.writeFileSync(fileName, content)

module.exports.CopyFile = (source, target, forceOverwrite)->
	if fs.existsSync(target) && ! forceOverwrite
		console.log 'target file exist and no force option is specified.'
		console.log 'target file will not be changed.'
		return

	if ! fs.existsSync(target)
		fs.createReadStream(source).pipe(fs.createWriteStream(target))

module.exports.DeleteFile = (fileToDelete)->
	fs.unlink(fileToDelete)

# MAIN
if ! @ParseParameter(process.argv)
	console.log "Please call this utility using: "
	console.log "node ConvertEmuToJson.js <EmuTestCardDir> <OutputJsonFile> [-f]"
	return

emuSourceDir = @EmuSourceDir
outputJsonFile = @OutputJsonFile

if ! fs.existsSync(emuSourceDir)
	console.log "Given EMU Test Card Folder: #{emuSourceDir} doesn't exist."
	console.log "Converter can't proceed."
	return

if ! @IsValidEmuTestCardDir(emuSourceDir)
	console.log "#{emuSourceDir} is not valid EMU Test Card directory."
	console.log "Converter can't proceed"
	return

jsonContent = @ConvertEmuTestCard(emuSourceDir)

tempJsonFile = @GetTempFileName()
@SaveFileContent(tempJsonFile, jsonContent)

# copy temporary file to output target file.
# if target file exist, ask user if no -f option is given.
forceOverwrite = @ForceOption

if fs.existsSync(@outputJsonFile) && !forceOverwrite
	console.log "Target JSON file exists: #{outputJsonFile} \
	and user did not use -f option to overwrite"
	return

@CopyFile(tempJsonFile, outputJsonFile, forceOverwrite)

@DeleteFile(tempJsonFile)
