/** Runs the test suite. **/
function main() {
	Sys.putEnv("NODE_ENV", "test");
	Sys.command("lix Build --debug");
	Sys.exit(Sys.command("haxe test.hxml"));
}
