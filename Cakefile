{spawn} = require "node:child_process"
{readdir, rm} = require "node:fs/promises"
{extname, join} = require "node:path"
{env} = require "node:process"
pkg = require "./package.json"

option "-m", "--map", "Whether to generate source maps."

task "build", "Builds the project.", (options) ->
	sourcemaps = if options.map then ["--map"] else []
	run "coffee", "--compile", sourcemaps..., "--no-header", "--output", "lib", "src"

task "clean", "Deletes all generated files.", ->
	await rm join("lib", file), {recursive: true} for file in await readdir "lib" when not file.endsWith ".d.ts"
	await rm join("var", file), {recursive: true} for file in await readdir "var" when file isnt ".gitkeep"

task "dist", "Packages the project.", ->
	invoke "clean"
	invoke "build"

task "lint", "Performs the static analysis of source code.", ->
	exec "coffeelint", "--file", "etc/coffeelint.json", "Cakefile", "src"

task "publish", "Publishes the package.", ->
	invoke "dist"
	await run "npm", "publish", "--registry=#{registry}" for registry in ["https://registry.npmjs.org", "https://npm.pkg.github.com"]
	await run "git", action..., "v#{pkg.version}" for action in [["tag"], ["push", "origin"]]

task "test", "Runs the test suite.", ->
	env.NODE_TEST = "test"
	invoke "build"
	run "node", "--test", "--test-reporter=spec"

task "watch", "Watches for file changes.", ->
	run "coffee", "--compile", "--map", "--no-header", "--output", "lib", "--watch", "src"

###*
# Executes a command from a local package.
# @param {string} command The command to run.
# @param {...string} args The command arguments.
# @returns {Promise<void>} Resolves when the command is terminated.
###
exec = (command, args...) -> run "npm", "exec", "--", command, args...

###*
# Spawns a new process using the specified command.
# @param {string} command The command to run.
# @param {...string} args The command arguments.
# @returns {Promise<void>} Resolves when the command is terminated.
###
run = (command, args...) ->
	{promise, resolve, reject} = Promise.withResolvers()
	spawn command, args, {shell: true, stdio: "inherit"}
		.on "close", (code) -> if code then reject Error([command].concat(args).join(" ")) else resolve()
	promise
