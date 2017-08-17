Path = require "path"
fs = require "fs"
mkdirp = require "mkdirp"
logger = require "logger-sharelatex"
settings = require("settings-sharelatex")

module.exports = ResourceListManager =

	# This file is a list of the input files for the project, one per
	# line, used to identify output files (i.e. files not on this list)
	# when the incoming request is incremental.
	RESOURCE_LIST_FILE: ".project-resource-list"

	saveResourceList: (resources, basePath, callback = (error) ->) ->
		resourceListFile = Path.join(basePath, @RESOURCE_LIST_FILE)
		resourceList = (resource.path for resource in resources)
		fs.writeFile resourceListFile, resourceList.join("\n"), callback

	loadResourceList: (basePath, callback = (error) ->) ->
		resourceListFile = Path.join(basePath, @RESOURCE_LIST_FILE)
		fs.readFile resourceListFile, (err, resourceList) ->
			return callback(err) if err?
			resources = ({path: path} for path in resourceList?.toString()?.split("\n") or [])
			callback(null, resources)
