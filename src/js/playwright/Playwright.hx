package js.playwright;

/** Launches a browser instance. **/
@:jsRequire("playwright")
extern class Playwright {

	/** An object that can be used to launch or connect to Chromium. **/
	static final chromium: Browser;

	/** An object that can be used to launch or connect to Firefox. **/
	static final firefox: Browser;

	/** An object that can be used to launch or connect to WebKit. **/
	static final webkit: Browser;
}
