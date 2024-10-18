package js.puppeteer;

import js.lib.Promise;
import js.node.events.EventEmitter;

/** Represents a browser instance. **/
extern abstract class Browser extends EventEmitter<Browser> {

	/** Closes this browser and all associated pages. **/
	function close(): Promise<Void>;

	/** Creates a new page in the default browser context. **/
	function newPage(): Promise<Page>;
}
