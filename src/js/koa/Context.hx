package js.koa;

import haxe.DynamicAccess;

/** Encapsulates the Node.js `request` and `response` objects into a single object. **/
extern class Context {

	/** The response body. **/
	var body: Any;

	/** The namespace for passing information through middleware and to the views. **/
	var state: DynamicAccess<Dynamic>;

	/** The response media type. **/
	var type: String;
}
