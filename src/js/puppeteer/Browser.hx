package js.puppeteer;

import js.lib.Promise;

/** Represents a browser instance. **/
extern interface Browser {

	/** Closes the browser and all of its pages (if any were opened). **/
	function close(?options: {?reason: String}): Promise<Void>;

	/** Creates a new page in the browser context. **/
	function newPage(): Promise<Page>;
}
