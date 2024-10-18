package js.puppeteer;

import haxe.DynamicAccess;
import haxe.extern.EitherType;
import js.lib.Promise;

/** Provides methods to launch a browser instance or connect to an existing one. **/
@:jsRequire("puppeteer")
extern class Puppeteer {

	/** Launches a browser instance. **/
	static function launch(?options: LaunchOptions): Promise<Browser>;
}

/** Defines the options of the `Puppeteer.launch()` method. **/
typedef LaunchOptions = {

	/** Value indicating whether to ignore HTTPS errors during navigation. **/
	var ?acceptInsecureCerts: Bool;

	/** Additional command line arguments to pass to the browser instance. **/
	var ?args: Array<String>;

	/** Value indicating which browser to launch. **/
	var ?browser: SupportedBrowser;

	/** The Chrome release channel. **/
	var ?channel: ChromeReleaseChannel;

	/** The debugging port number to use. **/
	var ?debuggingPort: Int;

	/** Sets the viewport for each page. **/
	var ?defaultViewport: Null<Viewport>;

	/** Value indicating whether to auto-open a DevTools panel for each tab. **/
	var ?devtools: Bool;

	/** Value indicating whether to pipe the browser process `stdout` and `stderr` to `process.stdout` and `process.stderr`. **/
	var ?dumpio: Bool;

	/** The environment variables that will be visible to the browser. **/
	var ?env: DynamicAccess<String>;

	/** The path to a browser executable to use instead of the bundled browser. **/
	var ?executablePath: String;

	/** Additional preferences that can be passed when launching with Firefox. **/
	var ?extraPrefsFirefox: DynamicAccess<Any>;

	/** Value indicating whether to run the browser in headless mode. **/
	var ?headless: EitherType<Bool, String>;

	/** Value indicating whether to ignore the default Puppeteer arguments when creating a browser. **/
	var ?ignoreDefaultArgs: EitherType<Bool, Array<String>>;

	/** Value indicating whether to close the browser process on `SIGHUP`. **/
	var ?handleSIGHUP: Bool;

	/** Value indicating whether to close the browser process on `Ctrl+C`. **/
	var ?handleSIGINT: Bool;

	/** Value indicating whether to close the browser process on `SIGTERM`. **/
	var ?handleSIGTERM: Bool;

	/** Value indicating whether to connect to a browser over a pipe instead of a WebSocket. **/
	var ?pipe: Bool;

	/** The protocol used to launch or connect to a browser. **/
	var ?protocol: ProtocolType;

	/** The timeout setting for individual protocol (CDP) calls. **/
	var ?protocolTimeout: Int;

	/** Slows down Puppeteer operations by the specified amount of milliseconds to aid debugging. **/
	var ?slowMo: Int;

	/** Callback to decide if Puppeteer should connect to a given target or not. **/
	var ?targetFilter: Target -> Bool;

	/** The maximum time in milliseconds to wait for the browser to start. **/
	var ?timeout: Int;

	/** The path to a user data directory. **/
	var ?userDataDir: String;

	/** Value indicating whether to wait for the initial page to be ready. **/
	var ?waitForInitialPage: Bool;
}
