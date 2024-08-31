package js.eta;

import js.lib.Promise;

/** An instance of the Eta template engine. **/
@:jsRequire("eta", "Eta")
extern class Eta {

	/** Creates a new instance. **/
	function new(?config: Config);

	/** Synchronously renders the specified `template`. **/
	function render(template: String, ?data: {}): String;

	/** Asynchronously renders the specified `template`. **/
	function renderAsync(template: String, ?data: {}): Promise<String>;
}
