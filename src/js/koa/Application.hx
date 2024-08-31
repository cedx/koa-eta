package js.koa;

import js.html.AbortSignal;
import js.node.http.Server;
import js.node.net.Server.ServerListenOptionsTcp;

/** Represents a Koa application. **/
@:jsRequire("koa")
extern class Application {

	/** The prototype from which the request context is created. **/
	var context: Context;

	/** The application application. **/
	var env: String;

	/** Value indicating whether to trust the proxy header fields. **/
	var proxy: Bool;

	/** Creates a new application. **/
	function new(?options: ApplicationOptions);

	/** Creates and returns an HTTP server, passing the given arguments to `Server.listen()`. **/
	function listen(options: ListenOptions): Server;
}

/** Defines the options of an `Application` instance. **/
typedef ApplicationOptions = {

	/** The application application. **/
	var ?env: String;

	/** Value indicating whether to trust the proxy header fields. **/
	var ?proxy: Bool;
}

/** Defines the options of the `Application.listen()` method. **/
typedef ListenOptions = ServerListenOptionsTcp & {

	/** A signal that may be used to close a listening server. **/
	var signal: AbortSignal;
}
