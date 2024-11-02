{spawnSync} = require "node:child_process"
{readdirSync, rmSync} = require "node:fs"
{extname, join} = require "node:path"
{env} = require "node:process"
pkg = require "./package.json"

option "-m", "--map", "Whether to generate source maps."

task "build", "Builds the project.", (options) ->
	sourcemaps = if options.map then ["--map"] else []
	run "coffee", "--compile", sourcemaps..., "--no-header", "--output", "lib", "src"

task "clean", "Deletes all generated files.", ->
	rmSync join("lib", file), {recursive: true} for file in readdirSync "lib" when not file.endsWith ".d.ts"
	rmSync join("var", file), {recursive: true} for file in readdirSync "var" when file isnt ".gitkeep"

task "dist", "Packages the project.", ->
	invoke "clean"
	invoke "build"

task "lint", "Performs the static analysis of source code.", ->
	npx "coffeelint", "--file=etc/coffeelint.json", "Cakefile", "src"

task "publish", "Publishes the package.", ->
	invoke "dist"
	run "npm", "publish", "--registry=#{registry}" for registry in ["https://registry.npmjs.org", "https://npm.pkg.github.com"]
	run "git", action..., "v#{pkg.version}" for action in [["tag"], ["push", "origin"]]

task "test", "Runs the test suite.", ->
	env.NODE_TEST = "test"
	invoke "build"
	run "node", "--enable-source-maps", "--test", "--test-reporter=spec"

task "watch", "Watches for file changes.", ->
	run "coffee", "--compile", "--map", "--no-header", "--output", "lib", "--watch", "src"

###*
# Executes a command from a local package.
# @param {string} command The command to run.
# @param {...string} args The command arguments.
###
npx = (command, args...) -> run "npm", "exec", "--", command, args...

###*
# Spawns a new process using the specified command.
# @param {string} command The command to run.
# @param {...string} args The command arguments.
# @returns {Promise<void>} Resolves when the command is terminated.
###
run = (command, args...) ->
	{status} = spawnSync command, args, {shell: true, stdio: "inherit"}
	if status isnt 0
		console.error "Command failed:", command, args...
		process.exit status
