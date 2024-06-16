import {cp, readFile, writeFile} from "node:fs/promises";
import {EOL} from "node:os";
import {env} from "node:process";
import {deleteAsync} from "del";
import {$} from "execa";
import gulp from "gulp";
import pkg from "./package.json" with {type: "json"};

// Builds the project.
export async function build() {
	await $`tsc --project src/tsconfig.json`;
	await cp("src/types.d.ts", "lib/types.d.ts");
	const types = await readFile("lib/index.d.ts", "utf8");
	return writeFile("lib/index.d.ts", types.replace("//# sourceMappingURL", `import "./types.js";${EOL}//# sourceMappingURL`));
}

// Deletes all generated files.
export function clean() {
	return deleteAsync(["lib", "var/**/*", "www"]);
}

// Performs the static analysis of source code.
export async function lint() {
	await $`tsc --project tsconfig.json`;
	return $`eslint --config=etc/eslint.config.js gulpfile.js example src test`;
}

// Publishes the package.
export async function publish() {
	for (const registry of ["https://registry.npmjs.org", "https://npm.pkg.github.com"]) await $`npm publish --registry=${registry}`;
	for (const action of [["tag"], ["push", "origin"]]) await $`git ${action} v${pkg.version}`;
}

// Runs the test suite.
export function test() {
	env.NODE_ENV = "test";
	return $`node --test --test-reporter=spec`;
}

// The default task.
export default gulp.series(
	clean,
	build
);
