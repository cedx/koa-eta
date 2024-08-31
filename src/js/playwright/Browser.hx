package js.playwright;

import haxe.DynamicAccess;
import js.lib.Promise;

/** Represents a browser instance. **/
extern interface Browser {

	/** Closes the browser and all of its pages (if any were opened). **/
	function close(?options: {?reason: String}): Promise<Void>;

	/** Creates a new page in the browser context. **/
	function newPage(): Promise<Page>;
}

/** Provides methods to launch a specific browser instance or connect to an existing one. **/
extern interface BrowserType {

	/** Returns the browser instance. **/
	function launch(?options: LaunchOptions): Promise<Browser>;
}

/** Defines the options of the `BrowserType.launch()` method. **/
typedef LaunchOptions = {

	/** Additional arguments to pass to the browser instance. **/
	var ?args: Array<String>;

	/** Value indicating whether to enable Chromium sandboxing. **/
	var ?chromiumSandbox: Bool;

	/** Value indicating whether to auto-open a Developer Tools panel for each tab. **/
	@:deprecated("Use the debugging tools (https://playwright.dev/docs/debug) instead.")
	var ?devtools: Bool;

	/** The environment variables that will be visible to the browser. **/
	var ?env: DynamicAccess<String>;

	/** Value indicating whether to run the browser in headless mode. **/
	var ?headless: Bool;

	/** The maximum time in milliseconds to wait for the browser instance to start. **/
	var ?timeout: Int;
}
