package js.eta;

import js.lib.Promise;

/** The Eta template engine. **/
@:jsRequire("eta", "Eta")
extern class Eta {

	/** Creates a new renderer. **/
	function new(config: Config);

	/** Synchronously renders the specified `template`. **/
	function render(template: String, ?data: {}): String;

	/** Asynchronously renders the specified `template`. **/
	function renderAsync(template: String, ?data: {}): Promise<String>;
}
