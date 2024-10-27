using Lambda;

/** Packages the project. **/
function main() {
	final file = "lib/bundle.js";
	for (script in ["Clean", "Build", "Version"]) Sys.command('lix $script');
	Sys.command('npx terser --comments=false --compress --mangle --output=$file $file');
}
