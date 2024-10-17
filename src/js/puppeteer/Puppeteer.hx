package js.puppeteer;

import js.puppeteer.Protocol.ProtocolType;
import haxe.DynamicAccess;
import js.lib.Promise;
import js.puppeteer.Browser;
import js.puppeteer.Viewport;

/** Defines the options of the `Puppeteer.launch()` method. **/
typedef LaunchOptions = {

	/** Value indicating whether to ignore HTTPS errors during navigation. **/
	var ?acceptInsecureCerts: Bool;

	/** Sets the viewport for each page. **/
	var ?defaultViewport: Null<Viewport>;

	/** The protocol used to launch or connect to a browser. **/
	var ?protocol: ProtocolType;

	/** The timeout setting for individual protocol (CDP) calls. **/
	var ?protocolTimeout: Int;

	/** Slows down Puppeteer operations by the specified amount of milliseconds to aid debugging. **/
	var ?slowMo: Int;








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

/** Provides methods to launch a browser instance or connect to an existing one. **/
@:jsRequire("puppeteer")
extern class Puppeteer {

	/** Launches a browser instance. **/
	static function launch(?options: LaunchOptions): Promise<Browser>;
}
