using Lambda;

/** Packages the project. **/
function main() {
	final file = "lib/bundle.js";
	for (script in ["Clean", "Build", "Version"]) Sys.command('lix $script');
	Sys.command('npx esbuild --allow-overwrite --legal-comments=none --log-level=warning --minify --outfile=$file --platform=node $file');
}
