package js.koa;

import js.html.AbortSignal;

/** TODO **/
@:jsRequire("koa")
extern class Application {

	/** TODO **/
	final context: Context;

	/** TODO **/
	function listen(options: ListenOptions): Void;
}

/** Defines the options of the `Application.listen()` method. **/
typedef ListenOptions = {

	/** TODO **/
	var host: String;

	/** TODO **/
	var port: Int;

	/** TODO **/
	var signal: AbortSignal;
}
